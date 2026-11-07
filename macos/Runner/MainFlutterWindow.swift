import Cocoa
import FlutterMacOS
import EventKit

class MainFlutterWindow: NSWindow, NSWindowDelegate {
  private let eventStore = EKEventStore()
  private var calendarChannel: FlutterMethodChannel?

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
