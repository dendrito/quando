import AVFoundation
import Flutter
import os.log
#if canImport(AlarmKit)
import ActivityKit
import AlarmKit
import AppIntents
import SwiftUI
#endif

/// Quando?: a system alarm (AlarmKit, iOS 26+) behind every alarm, so it still
/// rings after iOS ends the app or it is swiped away.
///
/// It is set a few seconds after the alarm's own time. A living app rings first
/// with its own sound and screen, and cancels it once that sound is playing. A
/// dead or suspended app cannot, so the system rings. Below iOS 26, or without
/// permission, every call here does nothing and the old path is all there is.
public enum AlarmKitBackup {
    /// How long after the alarm's time the system alarm is set.
    static let delay: TimeInterval = 4

    private static let logger = OSLog(subsystem: ALARM_BUNDLE, category: "AlarmKitBackup")
    private static let storagePrefix = "flutter.__alarm_id__"

    #if canImport(AlarmKit) && !targetEnvironment(macCatalyst)
    /// The app supplies the Snooze button's intent: App Intents have to live in
    /// the app target for iOS to find them.
    @available(iOS 26.0, *)
    public static var snoozeIntent: ((Int) -> any LiveActivityIntent)? {
        get { storedIntent as? (Int) -> any LiveActivityIntent }
        set { storedIntent = newValue }
    }

    private static var storedIntent: Any?

    private struct Metadata: AlarmMetadata {}

    private static var onThisDevice: Bool {
        if #available(iOS 14.0, *) { return !ProcessInfo.processInfo.isiOSAppOnMac }
        return false
    }

    private static func uuid(_ id: Int) -> UUID {
        let low = UInt64(bitPattern: Int64(id)) & 0xFFFF_FFFF_FFFF
        return UUID(uuidString: String(format: "51554144-4F00-4000-8000-%012llX", low))!
    }

    @available(iOS 26.0, *)
    private static func all() -> [AlarmKit.Alarm] {
        (try? AlarmKit.AlarmManager.shared.alarms) ?? []
    }

    /// Whether the alarm's own time has passed, so the system alarm is ringing
    /// or about to.
    @available(iOS 26.0, *)
    private static func isDue(_ alarm: AlarmKit.Alarm) -> Bool {
        if alarm.state == .alerting { return true }
        guard case .fixed(let date)? = alarm.schedule else { return false }
        return date.timeIntervalSinceNow <= delay
    }
    #endif

    static var authorized: Bool {
        #if canImport(AlarmKit) && !targetEnvironment(macCatalyst)
        if #available(iOS 26.0, *), onThisDevice {
            return AlarmKit.AlarmManager.shared.authorizationState == .authorized
        }
        #endif
        return false
    }

    /// Sets the system alarm. Returns its time, or nil if there is none.
    static func schedule(_ settings: AlarmSettings, registrar: FlutterPluginRegistrar?) async -> Date? {
        let payload = storedPayload(settings.id)
        // Silent reminders, the soft lead-up and lock mode must not ring loudly.
        if settings.volumeSettings.volume == 0 || payload["gentle"] as? Bool == true
            || payload["isLock"] as? Bool == true {
            return nil
        }
        // A system alarm rings until it is touched: never on Shabbat or a
        // festival. Those alarms rely on the app alone, which stops them itself.
        if payload["shabbatSafe"] as? Bool == true {
            return nil
        }
        return await schedule(
            id: settings.id,
            date: settings.dateTime,
            title: settings.notificationSettings.title,
            stopLabel: settings.notificationSettings.stopButton ?? payload["stopLabel"] as? String ?? "Stop",
            snoozeLabel: canSnooze(payload) ? payload["snoozeLabel"] as? String ?? "Snooze" : nil,
            sound: soundURL(settings.assetAudioPath, registrar: registrar))
    }

    private static func schedule(id: Int, date: Date, title: String, stopLabel: String, snoozeLabel: String?, sound: URL?) async -> Date? {
        #if canImport(AlarmKit) && !targetEnvironment(macCatalyst)
        guard #available(iOS 26.0, *), onThisDevice else { return nil }
        let manager = AlarmKit.AlarmManager.shared
        var state = manager.authorizationState
        if state == .notDetermined {
            state = (try? await manager.requestAuthorization()) ?? state
        }
        guard state == .authorized else { return nil }

        var snooze: AlarmButton?
        var intent: (any LiveActivityIntent)?
        if let snoozeLabel, let make = snoozeIntent {
            snooze = AlarmButton(text: LocalizedStringResource(String.LocalizationValue(snoozeLabel)),
                                 textColor: .white, systemImageName: "zzz")
            intent = make(id)
        }
        let heading = LocalizedStringResource(String.LocalizationValue(title))
        let alert: AlarmPresentation.Alert
        if #available(iOS 26.1, *) {
            alert = AlarmPresentation.Alert(
                title: heading, secondaryButton: snooze,
                secondaryButtonBehavior: snooze == nil ? nil : .custom)
        } else {
            alert = AlarmPresentation.Alert(
                title: heading,
                stopButton: AlarmButton(text: LocalizedStringResource(String.LocalizationValue(stopLabel)),
                                        textColor: .white, systemImageName: "stop.fill"),
                secondaryButton: snooze,
                secondaryButtonBehavior: snooze == nil ? nil : .custom)
        }
        let fireAt = date.addingTimeInterval(delay)
        let configuration = AlarmKit.AlarmManager.AlarmConfiguration<Metadata>.alarm(
            schedule: .fixed(fireAt),
            attributes: AlarmAttributes<Metadata>(presentation: AlarmPresentation(alert: alert), tintColor: .indigo),
            secondaryIntent: intent,
            sound: alertSound(sound))

        cancel(id: id)
        // iOS limits how many alarms an app may hold: the soonest ones win.
        while true {
            do {
                _ = try await manager.schedule(id: uuid(id), configuration: configuration)
                os_log(.info, log: logger, "System alarm set for ID=%d.", id)
                return fireAt
            } catch AlarmKit.AlarmManager.AlarmError.maximumLimitReached {
                let later = all().compactMap { alarm -> (UUID, Date)? in
                    guard case .fixed(let other)? = alarm.schedule, other > fireAt else { return nil }
                    return (alarm.id, other)
                }
                guard let latest = later.max(by: { $0.1 < $1.1 }),
                      (try? manager.cancel(id: latest.0)) != nil else { return nil }
            } catch {
                os_log(.error, log: logger, "System alarm for ID=%d failed: %@", id, error.localizedDescription)
                return nil
            }
        }
        #else
        return nil
        #endif
    }

    static func cancel(id: Int) {
        #if canImport(AlarmKit) && !targetEnvironment(macCatalyst)
        if #available(iOS 26.0, *), onThisDevice, let alarm = all().first(where: { $0.id == uuid(id) }) {
            if alarm.state == .alerting {
                try? AlarmKit.AlarmManager.shared.stop(id: alarm.id)
            } else {
                try? AlarmKit.AlarmManager.shared.cancel(id: alarm.id)
            }
        }
        #endif
    }

    /// Cancels every system alarm still to come. One that is ringing now is
    /// left: opening the app must not silence it before its screen shows.
    static func cancelUpcoming() {
        #if canImport(AlarmKit) && !targetEnvironment(macCatalyst)
        if #available(iOS 26.0, *), onThisDevice {
            for alarm in all() where !isDue(alarm) {
                try? AlarmKit.AlarmManager.shared.cancel(id: alarm.id)
            }
        }
        #endif
    }

    /// Whether the system is ringing this alarm (any of ours when id is nil).
    static func isRinging(id: Int?) -> Bool {
        #if canImport(AlarmKit) && !targetEnvironment(macCatalyst)
        if #available(iOS 26.0, *), onThisDevice {
            return all().contains { (id == nil || $0.id == uuid(id!)) && isDue($0) }
        }
        #endif
        return false
    }

    /// True once a system alarm that should have rung is gone: it was stopped on
    /// the system screen, so the app must not ring it again.
    static func wasStopped(id: Int, fireAt: Date) -> Bool {
        #if canImport(AlarmKit) && !targetEnvironment(macCatalyst)
        if #available(iOS 26.0, *), authorized, fireAt.timeIntervalSinceNow < -1 {
            guard let alarms = try? AlarmKit.AlarmManager.shared.alarms else { return false }
            return !alarms.contains { $0.id == uuid(id) }
        }
        #endif
        return false
    }

    /// Snooze pressed on the system screen. Saves the snoozed alarm where Dart
    /// keeps its alarms, so the app takes it over the next time it runs.
    public static func snooze(id: Int) async {
        cancel(id: id)
        let defaults = UserDefaults.standard
        var payload = storedPayload(id)
        guard var stored = storedAlarm(id), canSnooze(payload) else {
            await SwiftAlarmPlugin.getApi()?.systemStopped(id: id)
            return
        }
        let count = (payload["snoozeCount"] as? Int ?? 0) + 1
        let minutes = payload["snoozeMinutes"] as? Int ?? 5
        let date = Date().addingTimeInterval(TimeInterval(minutes * 60))
        let newId = stableId("snooze|\(id)|\(count)")

        payload["snoozeCount"] = count
        payload["snoozeMinutes"] = min(max(minutes - (payload["shortenBy"] as? Int ?? 0), 1), 120)
        payload["transient"] = true
        guard let payloadData = try? JSONSerialization.data(withJSONObject: payload) else { return }
        let format = DateFormatter()
        format.locale = Locale(identifier: "en_US_POSIX")
        format.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        stored["id"] = newId
        stored["dateTime"] = format.string(from: date)
        stored["payload"] = String(data: payloadData, encoding: .utf8)
        guard let data = try? JSONSerialization.data(withJSONObject: stored),
              let json = String(data: data, encoding: .utf8) else { return }
        defaults.set(json, forKey: "\(storagePrefix)\(newId)")
        defaults.removeObject(forKey: "\(storagePrefix)\(id)")

        let notification = stored["notificationSettings"] as? [String: Any] ?? [:]
        // The system alarm first: it must not wait for the app.
        _ = await schedule(
            id: newId, date: date,
            title: notification["title"] as? String ?? "Alarm",
            stopLabel: payload["stopLabel"] as? String ?? "Stop",
            snoozeLabel: canSnooze(payload) ? payload["snoozeLabel"] as? String ?? "Snooze" : nil,
            sound: soundURL(stored["assetAudioPath"] as? String, registrar: nil))
        // A running app also takes it over, to ring it as usual.
        await SwiftAlarmPlugin.getApi()?.systemSnoozed(from: id, to: newId, at: date)
    }

    private static func storedAlarm(_ id: Int) -> [String: Any]? {
        guard let json = UserDefaults.standard.string(forKey: "\(storagePrefix)\(id)") else { return nil }
        return (try? JSONSerialization.jsonObject(with: Data(json.utf8))) as? [String: Any]
    }

    private static func storedPayload(_ id: Int) -> [String: Any] {
        guard let json = storedAlarm(id)?["payload"] as? String else { return [:] }
        return (try? JSONSerialization.jsonObject(with: Data(json.utf8))) as? [String: Any] ?? [:]
    }

    /// The same rules as the ringing screen. Never on Shabbat or a festival.
    private static func canSnooze(_ payload: [String: Any]) -> Bool {
        return payload["shabbatSafe"] as? Bool != true
            && payload["isCheck"] as? Bool != true
            && (payload["snoozeTask"] as? String ?? "none") == "none"
            && (payload["snoozeCount"] as? Int ?? 0) < (payload["maxSnoozes"] as? Int ?? 0)
    }

    /// Dart's `stableId`, so a snooze gets the same id either way.
    private static func stableId(_ input: String) -> Int {
        var hash: UInt32 = 0x811c9dc5
        for unit in input.utf16 {
            hash = (hash ^ UInt32(unit)) &* 0x01000193
        }
        return Int(hash & 0x7fffffff)
    }

    /// The alarm's own sound file, found where the ring manager finds it.
    private static func soundURL(_ path: String?, registrar: FlutterPluginRegistrar?) -> URL? {
        guard let path else {
            #if SWIFT_PACKAGE
            return Bundle.module.url(forResource: "default", withExtension: "m4a")
            #else
            return Bundle(for: AlarmRingManager.self).url(forResource: "alarm", withExtension: "bundle")
                .flatMap { Bundle(url: $0)?.url(forResource: "default", withExtension: "m4a") }
            #endif
        }
        if path.hasPrefix("assets/") || path.hasPrefix("asset/") {
            let key = registrar?.lookupKey(forAsset: path) ?? FlutterDartProject.lookupKey(forAsset: path)
            return Bundle.main.path(forResource: key, ofType: nil).map { URL(fileURLWithPath: $0) }
        }
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?
            .appendingPathComponent(path)
    }

    #if canImport(AlarmKit) && !targetEnvironment(macCatalyst)
    /// The system only plays sounds from Library/Sounds, so the file is copied
    /// there as up to 30 seconds of plain PCM. Falls back to the system sound.
    @available(iOS 26.0, *)
    private static func alertSound(_ source: URL?) -> AlertConfiguration.AlertSound {
        guard let source,
              let library = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first
        else { return .default }
        let size = (try? source.resourceValues(forKeys: [.fileSizeKey]))?.fileSize ?? 0
        let name = "quando_\(source.deletingPathExtension().lastPathComponent)_\(size).caf"
        let folder = library.appendingPathComponent("Sounds", isDirectory: true)
        let target = folder.appendingPathComponent(name)
        if !FileManager.default.fileExists(atPath: target.path) {
            let partial = folder.appendingPathComponent("partial_\(UUID().uuidString).caf")
            do {
                try FileManager.default.createDirectory(at: folder, withIntermediateDirectories: true)
                try convert(source, to: partial)
                try FileManager.default.moveItem(at: partial, to: target)
            } catch {
                try? FileManager.default.removeItem(at: partial)
                os_log(.error, log: logger, "Sound could not be prepared: %@", error.localizedDescription)
                return .default
            }
        }
        return .named(name)
    }

    private static func convert(_ source: URL, to target: URL) throws {
        let input = try AVAudioFile(forReading: source)
        let format = input.processingFormat
        // Released on return, which finishes writing the file.
        let output = try AVAudioFile(
            forWriting: target,
            settings: [
                AVFormatIDKey: kAudioFormatLinearPCM,
                AVSampleRateKey: format.sampleRate,
                AVNumberOfChannelsKey: format.channelCount,
                AVLinearPCMBitDepthKey: 16,
                AVLinearPCMIsFloatKey: false,
            ],
            commonFormat: format.commonFormat, interleaved: format.isInterleaved)
        guard let buffer = AVAudioPCMBuffer(pcmFormat: format, frameCapacity: 32_768) else {
            throw CocoaError(.fileWriteUnknown)
        }
        var left = min(input.length, AVAudioFramePosition(format.sampleRate * 29))
        while left > 0 {
            try input.read(into: buffer, frameCount: AVAudioFrameCount(min(left, 32_768)))
            if buffer.frameLength == 0 { break }
            try output.write(from: buffer)
            left -= AVAudioFramePosition(buffer.frameLength)
        }
    }
    #endif
}
