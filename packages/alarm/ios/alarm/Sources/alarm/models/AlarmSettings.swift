import Foundation

struct AlarmSettings {
    let id: Int
    let dateTime: Date
    let assetAudioPath: String?
    let volumeSettings: VolumeSettings
    let notificationSettings: NotificationSettings
    let loopAudio: Bool
    let vibrate: Bool
    let warningNotificationOnKill: Bool
    let androidFullScreenIntent: Bool
    let allowAlarmOverlap: Bool
    let allowSameSecondScheduling: Bool
    let iOSBackgroundAudio: Bool

    /// The same alarm under another id and time (a snooze).
    func moved(to newId: Int, at date: Date) -> AlarmSettings {
        return AlarmSettings(
            id: newId, dateTime: date, assetAudioPath: assetAudioPath, volumeSettings: volumeSettings,
            notificationSettings: notificationSettings, loopAudio: loopAudio, vibrate: vibrate,
            warningNotificationOnKill: warningNotificationOnKill,
            androidFullScreenIntent: androidFullScreenIntent, allowAlarmOverlap: allowAlarmOverlap,
            allowSameSecondScheduling: allowSameSecondScheduling, iOSBackgroundAudio: iOSBackgroundAudio)
    }

    /// Converts from wire model to `AlarmSettings`.
    static func from(wire: AlarmSettingsWire) -> AlarmSettings {
        return AlarmSettings(
            id: Int(truncatingIfNeeded: wire.id),
            dateTime: Date(timeIntervalSince1970: TimeInterval(wire.millisecondsSinceEpoch) / 1_000.0),
            assetAudioPath: wire.assetAudioPath,
            volumeSettings: VolumeSettings.from(wire: wire.volumeSettings),
            notificationSettings: NotificationSettings.from(wire: wire.notificationSettings),
            loopAudio: wire.loopAudio,
            vibrate: wire.vibrate,
            warningNotificationOnKill: wire.warningNotificationOnKill,
            androidFullScreenIntent: wire.androidFullScreenIntent,
            allowAlarmOverlap: wire.allowAlarmOverlap,
            allowSameSecondScheduling: wire.allowSameSecondScheduling,
            iOSBackgroundAudio: wire.iOSBackgroundAudio
        )
    }
}
