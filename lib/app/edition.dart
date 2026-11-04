/// Which Quando? this is.
///
/// One codebase, two apps:
/// * the main Quando?, for everyone;
/// * Quando? Shabbat (`--dart-define=QUANDO_EDITION=kodesh`), for religious
///   Jews: Shabbat and Yom Tov first, Jewish sources only, no music apps,
///   radio or secular quotes to distract.
library;

import 'package:quando/l10n/l10n.dart';

const bool kodesh = String.fromEnvironment('QUANDO_EDITION') == 'kodesh';

/// The Jewish edition's own name, shown with "powered by Quando?".
const kodeshName = 'Zman';
const kodeshNameHe = 'זמן';

/// The app's name as people see it.
String get appTitle => !kodesh ? l10n.appName : (l10n.localeName == 'he' ? kodeshNameHe : kodeshName);
