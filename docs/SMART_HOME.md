# Smart home in Quando? and Matai?

Both editions have the same Connections controls. Local alarms continue even
when smart-home services are unavailable. These are alarm-event integrations,
not an always-running cloud scheduler: network requests require the app's alarm
delivery process to be running and online. Force-quit/background reliability
and real hardware behavior still require device testing.

## Test an existing Tuya project directly

1. In Connections, expand **Tuya · Smart Life**.
2. Enter the project's **data center**, **Access ID**, **Access Secret** and
   linked app account **UID**. The UID is listed under Link App Account in the
   Tuya developer project. Enter credentials in the app; never post them in chat.
3. Choose **Load scenes**. This authenticates and reads homes and available
   Tap-to-Run scenes; it never runs a scene. The cloud project needs access to
   Smart Home Basic Service and scene APIs for the linked account.
4. Tap a scene, review its name, then confirm **Run scene now**. This sends one
   command immediately. The response confirms Tuya accepted the command, not
   that a physical device changed state. Check the actual device.
5. To use it for an alarm, choose the scene under that alarm/reminder's
   **Smart home** row. Enable **Run smart-home alarm actions on this device** in
   Connections on the one device that should execute actions. Scene references
   follow alarm sync; execution permission remains local to avoid automatically
   running commands from every newly signed-in device.

An unattached scene never runs automatically. Matai's pause-on-Shabbat control
also suppresses smart-home alarm events inside the protected period. Manual
scene tests are explicit actions and do not use that alarm-event pause.

Errors show Tuya's code without echoing response bodies or credentials:
`1106` usually means API permission, `1004` signature/configuration,
`1013` device clock, and `28841001`/`28841002` missing/expired cloud access.
There are no automatic scene-command retries. A timeout leaves the physical
outcome unknown; check the device before testing again.

This direct mode uses each tester's own linked developer project. No shared
Quando developer secret is bundled. Tuya's trial prohibits commercial use;
a public direct Tuya service needs a suitable commercial agreement. Adding
this code does not subscribe to or purchase any service.

## Home Assistant and Node-RED

Connections can save a Home Assistant automation webhook or Node-RED HTTP In
endpoint. The app sends JSON POSTs with `event` (`ring`, `stopped`, `snoozed`,
`auto_stopped`), `title`, `body`, UTC `time`, `shabbat` and `snoozes`. Select the
events on the connection card. Configure an HTTP response for Node-RED.

Cloud endpoints use HTTPS. Home Assistant/Node-RED may use private IPv4 or
`.local` HTTP endpoints on the local network. iOS asks for local-network access.
The app does not disable TLS verification. A manual webhook test immediately
triggers the configured automation. New synced webhook connections are off
until enabled on that device. The smart-home device switch governs these two
providers; existing Zapier, IFTTT and other webhook behavior is preserved.

Home Assistant can supply access to Tuya, Matter and other integrations already
configured on the user's hub. This is distinct from native Quando drivers for
Apple Home, Google Home, Alexa, SmartThings or openHAB; none is claimed here.

## Sources and current limits

- [Tuya cloud signatures](https://developer.tuya.com/en/docs/iot/new-singnature?id=Kbw0q34cs2e5g)
- [Tuya endpoints and headers](https://developer.tuya.com/en/docs/iot/api-request?id=Ka4a8uuo1j4t4)
- [Tuya home management](https://developer.tuya.com/en/docs/cloud/smart-home-basic-service?id=Kconis1yii4be)
- [Tuya scenes](https://developer.tuya.com/en/docs/cloud/scene-and-automatic?id=K95zu0bsi8i8s)
- [Tuya commercial/trial policy](https://developer.tuya.com/en/docs/iot/membership-service?id=K9m8k45jwvg9j)
- [Home Assistant webhook triggers](https://www.home-assistant.io/docs/automation/trigger/)
- [Home Assistant Tuya integration](https://www.home-assistant.io/integrations/tuya/)

Provider contracts and deployed account access still require verification before
public release. Credentials currently use the app's existing SharedPreferences
and private Firestore sync, not end-to-end encryption; secure local storage and
a credential migration remain release work. No real account credentials or
hardware were used in automated tests.
