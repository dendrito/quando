import AppKit
import AVFoundation
import FlutterMacOS

/// Local alarms while the app is running and the Mac is awake. This host does
/// not install a daemon, wake the computer, or modify the system sound volume.
public final class MacOSAlarmPlugin: NSObject, FlutterPlugin, AlarmApi {
    private var timers: [Int64: Timer] = [:]
    private var players: [Int64: AVAudioPlayer] = [:]
    private var streams: [Int64: AVPlayer] = [:]
    private var fades: [Int64: Timer] = [:]
    private var ringing: Set<Int64> = []
    private var liveSettings: [Int64: AlarmSettingsWire] = [:]
    private var activity: NSObjectProtocol?
    private let callback: AlarmTriggerApi

    init(messenger: FlutterBinaryMessenger) {
        callback = AlarmTriggerApi(binaryMessenger: messenger)
        super.init()
        AlarmApiSetup.setUp(binaryMessenger: messenger, api: self)
        NSLog("Quando Mac alarm host initialized")
    }

    public static func register(with registrar: FlutterPluginRegistrar) {
        let plugin = MacOSAlarmPlugin(messenger: registrar.messenger)
        registrar.addApplicationDelegate(plugin)
    }

    func setAlarm(alarmSettings: AlarmSettingsWire, completion: @escaping (Result<Void, Error>) -> Void) {
        let id = alarmSettings.id
        cancel(id)
        let date = Date(timeIntervalSince1970: Double(alarmSettings.millisecondsSinceEpoch) / 1000)
        // Validate the offline fallback before accepting a scheduled alarm.
        do { _ = try audioPlayer(alarmSettings.assetAudioPath) }
        catch {
            NSLog("Quando Mac alarm scheduling failed: %@", error.localizedDescription)
            completion(.failure(PigeonError(
                code: String(AlarmErrorCode.pluginInternal.rawValue),
                message: "Could not load the Mac alarm sound (audio error \((error as NSError).code)).",
                details: nil)))
            return
        }
        liveSettings[id] = alarmSettings
        updateActivity()
        let timer = Timer(fire: max(date, Date().addingTimeInterval(0.05)), interval: 0, repeats: false) { [weak self] _ in
            self?.start(id)
        }
        timers[id] = timer
        RunLoop.main.add(timer, forMode: .common)
        NSLog("Quando Mac alarm scheduled id=%lld", id)
        completion(.success(()))
    }

    private func audioPlayer(_ path: String?) throws -> AVAudioPlayer {
        let fallback = assetURL("assets/sounds/classic_beep.wav")
        let selected: URL
        if let path, path.hasPrefix("assets/") || path.hasPrefix("packages/") {
            let compatible = assetURL(String(path.dropLast(4)) + ".m4a")
            selected = path.hasSuffix(".ogg") && FileManager.default.fileExists(atPath: compatible.path)
                ? compatible : assetURL(path)
        } else if let path, path.hasPrefix("/") {
            selected = URL(fileURLWithPath: path)
        } else if let path, !path.hasPrefix("http://"), !path.hasPrefix("https://") {
            selected = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                .appendingPathComponent(path)
        } else {
            selected = fallback
        }
        // Removed files and unsupported codecs must still produce an alarm.
        if let player = try? AVAudioPlayer(contentsOf: selected) { return player }
        return try AVAudioPlayer(contentsOf: fallback)
    }

    private func assetURL(_ path: String) -> URL {
        // AOT App.framework is loaded by the Flutter engine, and need not be
        // registered with NSBundle by identifier. Resolve its actual resource
        // location instead of falling back to the runner's Resources folder.
        let frameworks = Bundle.main.privateFrameworksURL
            ?? Bundle.main.bundleURL.appendingPathComponent("Contents/Frameworks")
        return frameworks.appendingPathComponent("App.framework/Resources/flutter_assets")
            .appendingPathComponent(path)
    }

    private func start(_ id: Int64) {
        guard let settings = liveSettings[id] else { return }
        timers.removeValue(forKey: id)
        if !settings.allowAlarmOverlap {
            for other in Array(ringing) where other != id {
                cancel(other)
                callback.alarmStopped(alarmId: other) { _ in }
            }
        }
        do {
            let player = try audioPlayer(settings.assetAudioPath)
            player.numberOfLoops = settings.loopAudio ? -1 : 0
            let volume = Float(min(1, max(0, settings.volumeSettings.volume ?? 1)))
            player.volume = settings.volumeSettings.fadeDurationMillis == nil && settings.volumeSettings.fadeSteps.isEmpty ? volume : 0
            player.prepareToPlay()
            guard player.play() else { throw NSError(domain: "QuandoAlarm", code: 1) }
            players[id] = player
            ringing.insert(id)
            applyFade(id, settings.volumeSettings, volume)
            if let path = settings.assetAudioPath, let url = URL(string: path),
               url.scheme == "https" || url.scheme == "http" {
                let stream = AVPlayer(url: url)
                stream.volume = volume
                streams[id] = stream
                stream.play()
                fades.removeValue(forKey: id)?.invalidate()
                // Keep the local backup until the stream is actually playing.
                // A stall later also brings that backup back.
                do {
                    let monitor = Timer(timeInterval: 0.5, repeats: true) { [weak self] _ in
                        self?.players[id]?.volume = stream.timeControlStatus == .playing ? 0 : volume
                    }
                    fades[id] = monitor
                    RunLoop.main.add(monitor, forMode: .common)
                }
            }
            if settings.androidFullScreenIntent {
                NSApp.activate(ignoringOtherApps: false)
                NSApp.windows.first(where: { $0.contentViewController is FlutterViewController })?.makeKeyAndOrderFront(nil)
            }
            callback.alarmRang(alarmId: id) { _ in }
            NSLog("Quando Mac alarm audio started id=%lld", id)
        } catch {
            NSLog("Quando alarm audio could not start: %@", error.localizedDescription)
            cancel(id)
        }
    }

    private func applyFade(_ id: Int64, _ settings: VolumeSettingsWire, _ target: Float) {
        let steps = settings.fadeSteps.sorted { $0.timeMillis < $1.timeMillis }
        if !steps.isEmpty {
            let started = Date()
            let timer = Timer(timeInterval: 0.05, repeats: true) { [weak self] timer in
                guard let self, let player = self.players[id] else { timer.invalidate(); return }
                let elapsed = Date().timeIntervalSince(started) * 1000
                if let last = steps.last, elapsed >= Double(last.timeMillis) {
                    player.volume = target * Float(last.volume)
                    timer.invalidate()
                    self.fades.removeValue(forKey: id)
                    return
                }
                var previousTime = 0.0
                var previousVolume = 0.0
                for step in steps {
                    let end = Double(step.timeMillis)
                    if elapsed <= end {
                        let fraction = end > previousTime ? (elapsed - previousTime) / (end - previousTime) : 1
                        player.volume = target * Float(previousVolume + (step.volume - previousVolume) * min(1, max(0, fraction)))
                        break
                    }
                    previousTime = end
                    previousVolume = step.volume
                }
            }
            fades[id] = timer
            RunLoop.main.add(timer, forMode: .common)
        } else if let milliseconds = settings.fadeDurationMillis {
            players[id]?.setVolume(target, fadeDuration: Double(milliseconds) / 1000)
        }
    }

    private func cancel(_ id: Int64) {
        timers.removeValue(forKey: id)?.invalidate()
        fades.removeValue(forKey: id)?.invalidate()
        players.removeValue(forKey: id)?.stop()
        streams.removeValue(forKey: id)?.pause()
        ringing.remove(id)
        liveSettings.removeValue(forKey: id)
        updateActivity()
    }

    private func updateActivity() {
        if !liveSettings.isEmpty && activity == nil {
            activity = ProcessInfo.processInfo.beginActivity(
                options: [.userInitiatedAllowingIdleSystemSleep],
                reason: "Keep scheduled alarms responsive while the Mac is awake.")
        } else if liveSettings.isEmpty, let current = activity {
            ProcessInfo.processInfo.endActivity(current)
            activity = nil
        }
    }

    func stopAlarm(alarmId: Int64, completion: @escaping (Result<Void, Error>) -> Void) {
        cancel(alarmId)
        NSLog("Quando Mac alarm stopped id=%lld", alarmId)
        completion(.success(()))
    }

    func stopAll(completion: @escaping (Result<Void, Error>) -> Void) {
        for id in Array(liveSettings.keys) { cancel(id) }
        completion(.success(()))
    }

    func isRinging(alarmId: Int64?) throws -> Bool {
        alarmId.map { ringing.contains($0) } ?? !ringing.isEmpty
    }

    func getAlarmState(alarmId: Int64) throws -> AlarmStateWire {
        ringing.contains(alarmId) ? .ringing : .inactive
    }

    func setWarningNotificationOnKill(title: String, body: String) throws {}
    func disableWarningNotificationOnKill() throws {}
    func getPendingAlarmEvents(completion: @escaping (Result<[AlarmEventWire], Error>) -> Void) { completion(.success([])) }
    func acknowledgeAlarmEvent(alarmId: Int64, recordedAtMillis: Int64, completion: @escaping (Result<Void, Error>) -> Void) { completion(.success(())) }
}
