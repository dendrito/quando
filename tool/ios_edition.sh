#!/usr/bin/env bash
# Switches the iPhone/iPad project to the Jewish edition before a build:
# its own bundle ID and home-screen name, so it installs as a separate app.
#   tool/ios_edition.sh kodesh && flutter build ios --dart-define=QUANDO_EDITION=kodesh
# Android does the same with its "kodesh" flavor (android/app/build.gradle.kts).
set -euo pipefail
cd "$(dirname "$0")/.."
case "${1:-}" in
  kodesh)
    sed -i.bak 's/PRODUCT_BUNDLE_IDENTIFIER = com\.dendrito\.quando;/PRODUCT_BUNDLE_IDENTIFIER = com.dendrito.quando.kodesh;/' ios/Runner.xcodeproj/project.pbxproj
    /usr/libexec/PlistBuddy -c "Set :CFBundleDisplayName Matai?" ios/Runner/Info.plist 2>/dev/null \
      || sed -i.bak 's#<string>Quando?</string>#<string>Matai?</string>#' ios/Runner/Info.plist
    rm -f ios/Runner.xcodeproj/project.pbxproj.bak ios/Runner/Info.plist.bak
    echo "iOS project set to Matai? (com.dendrito.quando.kodesh)"
    ;;
  quando) echo "iOS project is Quando? by default; nothing to change." ;;
  *) echo "usage: $0 quando|kodesh" >&2; exit 2 ;;
esac
