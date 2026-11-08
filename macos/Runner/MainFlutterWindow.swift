import Cocoa
import FlutterMacOS
import EventKit

class MainFlutterWindow: NSWindow, NSWindowDelegate {
  private let eventStore = EKEventStore()
  private var calendarChannel: FlutterMethodChannel?
  private let desktopMusic = DesktopMusicBridge()

  override func awakeFromNib() {
    let flutterViewController = FlutterViewController()
    self.contentViewController = flutterViewController
    self.setContentSize(NSSize(width: 1060, height: 760))
    self.minSize = NSSize(width: 640, height: 500)
    self.title = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String ?? "Quando?"
    self.center()
    self.delegate = self

    RegisterGeneratedPlugins(registry: flutterViewController)

    let channel = FlutterMethodChannel(name: "quando/calendar", binaryMessenger: flutterViewController.engine.binaryMessenger)
    calendarChannel = channel
    channel.setMethodCallHandler { [weak self] call, result in
      self?.calendarCall(call, result: result)
    }

    let media = FlutterMethodChannel(name: "quando/media", binaryMessenger: flutterViewController.engine.binaryMessenger)
    media.setMethodCallHandler { call, result in
      if call.method == "open", let args = call.arguments as? [String: Any],
         let raw = args["url"] as? String, let url = URL(string: raw),
         ["http", "https", "spotify", "music"].contains(url.scheme?.lowercased() ?? "") {
        result(NSWorkspace.shared.open(url))
      } else {
        // Never claim that an external music app started playback. The alarm
        // retains its local backup until a supported API proves playback.
        result(false)
      }
    }

    let music = FlutterMethodChannel(name: "quando/desktop_music", binaryMessenger: flutterViewController.engine.binaryMessenger)
    music.setMethodCallHandler { [weak self] call, result in
      self?.desktopMusic.handle(call, result: result)
    }

    super.awakeFromNib()
  }

  func windowShouldClose(_ sender: NSWindow) -> Bool {
    orderOut(nil)
    return false
  }

  private var hasCalendarAccess: Bool {
    let status = EKEventStore.authorizationStatus(for: .event)
    if #available(macOS 14.0, *) { return status == .fullAccess }
    return status == .authorized
  }

  private func calendarCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if call.method == "hasAccess" { result(hasCalendarAccess); return }
    if call.method == "requestAccess" {
      let completed: (Bool, Error?) -> Void = { granted, error in
        DispatchQueue.main.async {
          if let error { result(FlutterError(code: "calendar-access", message: error.localizedDescription, details: nil)) }
          else { result(granted) }
        }
      }
      if #available(macOS 14.0, *) { eventStore.requestFullAccessToEvents(completion: completed) }
      else { eventStore.requestAccess(to: .event, completion: completed) }
      return
    }
    guard hasCalendarAccess else {
      result(FlutterError(code: "calendar-access", message: "Calendar access has not been granted.", details: nil))
      return
    }
    switch call.method {
    case "calendars":
      result(eventStore.calendars(for: .event).map { calendar in
        ["id": calendar.calendarIdentifier, "name": calendar.title, "account": calendar.source.title]
      })
    case "events":
      guard let args = call.arguments as? [String: Any],
            let from = args["from"] as? NSNumber, let to = args["to"] as? NSNumber,
            let ids = args["calendarIds"] as? [String], to.doubleValue > from.doubleValue else {
        result(FlutterError(code: "calendar-range", message: "Invalid calendar date range.", details: nil)); return
      }
      let calendars = eventStore.calendars(for: .event).filter { ids.contains($0.calendarIdentifier) }
      guard !calendars.isEmpty else { result([[String: Any]]()); return }
      let predicate = eventStore.predicateForEvents(
        withStart: Date(timeIntervalSince1970: from.doubleValue / 1000),
        end: Date(timeIntervalSince1970: to.doubleValue / 1000), calendars: calendars)
      result(eventStore.events(matching: predicate).filter { !$0.isAllDay && $0.status != .canceled }.map { event -> [String: Any] in
        let start = Int64(event.startDate.timeIntervalSince1970 * 1000)
        return ["instanceId": "\(event.calendar.calendarIdentifier):\(event.eventIdentifier ?? ""):\(start)",
                "calendarId": event.calendar.calendarIdentifier, "title": event.title ?? "",
                "start": start, "end": Int64(event.endDate.timeIntervalSince1970 * 1000)]
      })
    default: result(FlutterMethodNotImplemented)
    }
  }
}

/// The apps' published scripting interfaces, restricted to playback and
/// Music library reading. Commands are fixed; only validated media identifiers
/// or escaped, allowlisted Apple Music URLs may become script arguments.
private final class DesktopMusicBridge {
  // Apple DTS permits NSAppleScript on a serialized secondary thread since
  // macOS 10.6. Never wait for a music app on the alarm/UI thread.
  private let queue = DispatchQueue(label: "com.dendrito.quando.music", qos: .userInitiated)
  private var activeSession: String?
  private var activeService: String?
  private var newestPlay: Int64 = 0
  private var cancelledThrough: Int64 = 0
  private let apps = ["spotify": "com.spotify.client", "apple": "com.apple.Music"]

  func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    let args = call.arguments as? [String: Any] ?? [:]
    queue.async { [self] in
      do {
        let response: Any?
        switch call.method {
        case "connect":
          let service = args["service"] as? String ?? ""
          _ = try run(service, "return player state as text", timeout: 10)
          response = nil
        case "library":
          guard args["service"] as? String == "apple" else { throw failure("Unsupported library") }
          let playlists = try readPlaylists()
          let songs = try readTracks(in: "library playlist 1", limit: 1000)
          response = ["playlists": playlists, "songs": songs]
        case "playlistTracks":
          guard let id = args["id"] as? String, matches(id, "^[A-Fa-f0-9]{16}$") else { throw failure("Unsupported playlist") }
          response = try readTracks(in: "(first user playlist whose persistent ID is \(quoted(id)))", limit: 500)
        case "search":
          let query = (args["query"] as? String ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
          guard !query.isEmpty, query.count <= 100 else { throw failure("Type something to search") }
          response = try searchTracks(query)
        case "play":
          let service = args["service"] as? String ?? ""
          let link = args["link"] as? String ?? ""
          guard let session = args["session"] as? String, !session.isEmpty else { throw failure("Missing playback session") }
          guard let generation = generationOf(session), generation > cancelledThrough, generation >= newestPlay else {
            DispatchQueue.main.async { result(false) }
            return
          }
          newestPlay = generation
          let command: String
          if service == "spotify", matches(link, "^spotify:(track|playlist|album|artist|episode|show):[A-Za-z0-9]+$") {
            command = "play track \(quoted(link))"
          } else if service == "apple", matches(link, "^quando-music:(playlist|track):[A-Fa-f0-9]{16}$") {
            let parts = link.split(separator: ":")
            let kind = parts[1] == "playlist" ? "user playlist" : "track of library playlist 1"
            command = "play (first \(kind) whose persistent ID is \(quoted(String(parts[2]))))"
          } else { throw failure("Unsupported music link") }
          _ = try run(service, command)
          activeSession = session
          activeService = service
          response = true
        case "playing":
          if args["session"] as? String == activeSession, let service = activeService {
            response = try run(service, "return player state as text").stringValue == "playing"
          } else { response = false }
        case "pause":
          if let session = args["session"] as? String, let generation = generationOf(session) {
            cancelledThrough = max(cancelledThrough, generation)
          }
          if args["session"] as? String == activeSession, let service = activeService {
            activeSession = nil
            activeService = nil
            _ = try run(service, "pause")
          }
          response = nil
        default:
          DispatchQueue.main.async { result(FlutterMethodNotImplemented) }
          return
        }
        DispatchQueue.main.async { result(response) }
      } catch {
        let ns = error as NSError
        DispatchQueue.main.async {
          result(FlutterError(code: "desktop-music-\(ns.code)", message: ns.localizedDescription, details: nil))
        }
      }
    }
  }

  private func readPlaylists() throws -> [[String: String]] {
    let reply = try run("apple", """
      set itemCount to count of user playlists
      if itemCount is 0 then return {}
      if itemCount > 1000 then set itemCount to 1000
      set counts to {}
      repeat with p in (user playlists 1 thru itemCount)
        set end of counts to (count of tracks of p) as text
      end repeat
      return {persistent ID of user playlists 1 thru itemCount, name of user playlists 1 thru itemCount, counts}
      """, timeout: 20)
    return columns(reply, keys: ["id", "name", "count"])
  }

  /// Songs of a library or playlist [container], with their artists, so a
  /// playlist can be opened to pick one song.
  private func readTracks(in container: String, limit: Int) throws -> [[String: String]] {
    let reply = try run("apple", """
      set c to \(container)
      set itemCount to count of tracks of c
      if itemCount is 0 then return {}
      if itemCount > \(limit) then set itemCount to \(limit)
      return {persistent ID of tracks 1 thru itemCount of c, name of tracks 1 thru itemCount of c, artist of tracks 1 thru itemCount of c}
      """, timeout: 20)
    return columns(reply, keys: ["id", "name", "artist"])
  }

  /// Music's own library search: songs whose name, artist or album match.
  private func searchTracks(_ query: String) throws -> [[String: String]] {
    let reply = try run("apple", """
      set found to search library playlist 1 for \(quoted(query))
      set n to count of found
      if n > 50 then set n to 50
      set ids to {}
      set names to {}
      set artists to {}
      repeat with i from 1 to n
        set t to item i of found
        set end of ids to persistent ID of t
        set end of names to name of t
        set end of artists to artist of t
      end repeat
      return {ids, names, artists}
      """, timeout: 15)
    return columns(reply, keys: ["id", "name", "artist"])
  }

  /// Turns {ids, names, …} into rows, keeping only valid persistent IDs.
  private func columns(_ reply: NSAppleEventDescriptor, keys: [String]) -> [[String: String]] {
    guard let ids = reply.atIndex(1), ids.numberOfItems > 0 else { return [] }
    let lists = (1...keys.count).map { reply.atIndex($0) }
    return (1...ids.numberOfItems).compactMap { index in
      guard let id = ids.atIndex(index)?.stringValue, matches(id, "^[A-Fa-f0-9]{16}$") else { return nil }
      var row = ["id": id]
      for (k, key) in keys.enumerated().dropFirst() {
        row[key] = lists[k]?.atIndex(index)?.stringValue ?? ""
      }
      return row["name"]?.isEmpty == false ? row : nil
    }
  }

  private func run(_ service: String, _ command: String, timeout: Int = 3) throws -> NSAppleEventDescriptor {
    guard let bundle = apps[service], NSWorkspace.shared.urlForApplication(withBundleIdentifier: bundle) != nil else {
      throw failure("Install and sign in to the selected music app first.")
    }
    var error: NSDictionary?
    guard let script = NSAppleScript(source: "with timeout of \(timeout) seconds\ntell application id \(quoted(bundle))\n\(command)\nend tell\nend timeout") else {
      throw failure("Could not prepare the music command.")
    }
    let response = script.executeAndReturnError(&error)
    if let error {
      let code = (error[NSAppleScript.errorNumber] as? NSNumber)?.intValue ?? -1
      if code == -1743 {
        throw NSError(domain: "QuandoMusic", code: code, userInfo: [NSLocalizedDescriptionKey:
          "Allow this app to control the selected music app in System Settings → Privacy & Security → Automation."])
      }
      throw failure("The music app could not complete this action (\(code)).")
    }
    return response
  }

  private func quoted(_ value: String) -> String {
    "\"" + value.replacingOccurrences(of: "\\", with: "\\\\").replacingOccurrences(of: "\"", with: "\\\"") + "\""
  }
  private func generationOf(_ session: String) -> Int64? {
    session.split(separator: ".").last.flatMap { Int64($0) }
  }
  private func matches(_ value: String, _ pattern: String) -> Bool {
    value.range(of: pattern, options: .regularExpression) != nil
  }
  private func failure(_ message: String) -> NSError {
    NSError(domain: "QuandoMusic", code: -1, userInfo: [NSLocalizedDescriptionKey: message])
  }
}
