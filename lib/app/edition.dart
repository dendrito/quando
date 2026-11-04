/// Which Quando? this is.
///
/// One codebase, two apps:
/// * the main Quando?, for everyone;
/// * Matai? On the Sabbath (מתי? בשבת in Hebrew) (`--dart-define=QUANDO_EDITION=kodesh`), for religious
///   Jews: Shabbat and Yom Tov first, Jewish quotes only, Israeli and
///   Jewish radio. Every other feature is the same.
library;

import 'package:quando/l10n/l10n.dart';

const bool kodesh = String.fromEnvironment('QUANDO_EDITION') == 'kodesh';

/// The Jewish edition's own name, shown with "powered by Quando?".
const kodeshName = 'Matai? On the Sabbath';
const kodeshNameHe = 'מתי? בשבת';

/// The app's name as people see it.
String get appTitle => !kodesh ? l10n.appName : (l10n.localeName == 'he' ? kodeshNameHe : kodeshName);
