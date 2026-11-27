import AVFoundation

enum AlarmState {
    case scheduled
    case ringing
}

class AlarmConfiguration {
    let settings: AlarmSettings

    var state: AlarmState = .scheduled
    var timer: Timer?
    /// When the system (AlarmKit) alarm behind this one rings, if there is one.
    var systemAlarmAt: Date?

    init(settings: AlarmSettings) {
        self.settings = settings
    }
}
