import EventKit
import Flutter
import MusicKit
import UIKit
import alarm

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // The alarm plugin schedules a background refresh to keep alarms alive.
    // iOS ends the app if that task isn't registered before launch finishes.
    SwiftAlarmPlugin.registerBackgroundTasks()
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
    if let registrar = engineBridge.pluginRegistry.registrar(forPlugin: "QuandoAppleMusic") {
      AppleMusicBridge.register(registrar.messenger())
    }
    if let registrar = engineBridge.pluginRegistry.registrar(forPlugin: "QuandoCalendarWatch") {
      CalendarWatch.register(registrar.messenger())
    }
  }
}

/// Calendar alarms follow the calendar: tells Dart the moment the phone's
/// calendars change (EventKit posts this for edits here, in other apps and
/// from syncing), while the app is open.
enum CalendarWatch {
  private static var channel: FlutterMethodChannel?
  private static var observer: NSObjectProtocol?

  static func register(_ messenger: FlutterBinaryMessenger) {
    let channel = FlutterMethodChannel(name: "quando/calendar_watch", binaryMessenger: messenger)
    self.channel = channel
    channel.setMethodCallHandler { call, result in
      switch call.method {
      case "start":
        start()
        result(true)
      case "stop":
        stop()
        result(true)
      default:
        result(FlutterMethodNotImplemented)
      }
    }
  }

  private static func start() {
    guard observer == nil else { return }
    observer = NotificationCenter.default.addObserver(
      forName: .EKEventStoreChanged, object: nil, queue: .main
    ) { _ in
      channel?.invokeMethod("changed", arguments: nil)
    }
  }

  private static func stop() {
    if let observer { NotificationCenter.default.removeObserver(observer) }
    observer = nil
  }
}

/// Apple Music through Apple's MusicKit, with the same calls the Mac's music
/// bridge answers (connect, library, playlistTracks, search, play, playing,
/// pause). Only library items can be played; Dart keeps it hidden unless
/// the build turns MusicKit on.
enum AppleMusicBridge {
  static func register(_ messenger: FlutterBinaryMessenger) {
    let channel = FlutterMethodChannel(name: "quando/desktop_music", binaryMessenger: messenger)
    channel.setMethodCallHandler { call, result in
      guard #available(iOS 16.0, *) else {
        result(FlutterError(code: "apple-music", message: "Apple Music needs iOS 16 or later.", details: nil))
        return
      }
      Task { @MainActor in
        do {
          result(try await AppleMusicCalls.handle(call))
        } catch {
          result(FlutterError(code: "apple-music", message: error.localizedDescription, details: nil))
        }
      }
    }
  }
}

@available(iOS 16.0, *)
@MainActor
enum AppleMusicCalls {
  private static var session: String?

  static func handle(_ call: FlutterMethodCall) async throws -> Any? {
    let args = call.arguments as? [String: Any] ?? [:]
    switch call.method {
    case "connect":
      try await authorize()
      return nil
    case "library":
      try await authorize()
      var lists = MusicLibraryRequest<Playlist>()
      lists.limit = 300
      var songs = MusicLibraryRequest<Song>()
      songs.limit = 1000
      let playlists = try await lists.response().items.map { ["id": $0.id.rawValue, "name": $0.name] }
      return ["playlists": playlists, "songs": try await songs.response().items.map(row)]
    case "playlistTracks":
      guard let playlist = try await playlist(args["id"] as? String) else { return [] }
      let full = try await playlist.with([.tracks])
      return (full.tracks ?? []).prefix(500).map { track in
        ["id": track.id.rawValue, "name": track.title, "artist": track.artistName]
      }
    case "search":
      let query = (args["query"] as? String ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
      guard !query.isEmpty, query.count <= 100 else { return [] }
      var request = MusicLibrarySearchRequest(term: query, types: [Song.self])
      request.limit = 50
      return try await request.response().songs.map(row)
    case "play":
      let link = args["link"] as? String ?? ""
      let parts = link.split(separator: ":").map(String.init)
      guard parts.count == 3, parts[0] == "quando-music", let id = args["session"] as? String else {
        throw failure("Unsupported music link")
      }
      let player = ApplicationMusicPlayer.shared
      if parts[1] == "playlist" {
        guard let item = try await playlist(parts[2]) else { throw failure("That playlist is no longer in your library.") }
        player.queue = [item]
      } else {
        var request = MusicLibraryRequest<Song>()
        request.filter(matching: \.id, equalTo: MusicItemID(parts[2]))
        guard let song = try await request.response().items.first else { throw failure("That song is no longer in your library.") }
        player.queue = [song]
      }
      try await player.play()
      session = id
      return true
    case "playing":
      return args["session"] as? String == session && ApplicationMusicPlayer.shared.state.playbackStatus == .playing
    case "pause":
      if args["session"] as? String == session {
        ApplicationMusicPlayer.shared.pause()
        session = nil
      }
      return nil
    default:
      return FlutterMethodNotImplemented
    }
  }

  private static func authorize() async throws {
    let status = await MusicAuthorization.request()
    guard status == .authorized else {
      throw failure("Allow Quando to use Apple Music in Settings › Privacy & Security › Media & Apple Music.")
    }
  }

  private static func playlist(_ id: String?) async throws -> Playlist? {
    guard let id, !id.isEmpty else { return nil }
    var request = MusicLibraryRequest<Playlist>()
    request.filter(matching: \.id, equalTo: MusicItemID(id))
    return try await request.response().items.first
  }

  private static func row(_ song: Song) -> [String: String] {
    ["id": song.id.rawValue, "name": song.title, "artist": song.artistName]
  }

  private static func failure(_ message: String) -> NSError {
    NSError(domain: "QuandoMusic", code: -1, userInfo: [NSLocalizedDescriptionKey: message])
  }
}
