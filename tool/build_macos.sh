#!/usr/bin/env bash
# Reproducible local Apple Silicon build. Does not install or publish anything.
set -euo pipefail
cd "$(dirname "$0")/.."
edition=${1:-quando}
case "$edition" in
  quando) name='Quando?' ;;
  kodesh) name='Matai?' ;;
  mine) name='Quando Mine' ;;
  *) echo 'usage: tool/build_macos.sh quando|kodesh|mine' >&2; exit 2 ;;
esac
out=${QUANDO_MAC_OUTPUT:-"$PWD/build/mac-editions"}
derived=${QUANDO_MAC_DERIVED_DATA:-"$PWD/build/macos"}
mkdir -p "$out"
saved=$(mktemp -d)
cp macos/Runner/Configs/AppInfo.xcconfig "$saved/AppInfo.xcconfig"
cp macos/Runner.xcodeproj/project.pbxproj "$saved/project.pbxproj"
restore() {
  cp "$saved/AppInfo.xcconfig" macos/Runner/Configs/AppInfo.xcconfig
  cp "$saved/project.pbxproj" macos/Runner.xcodeproj/project.pbxproj
}
trap restore EXIT
tool/macos_edition.sh "$edition"
flutter build macos --release --config-only --no-pub --dart-define="QUANDO_EDITION=$edition" \
  --dart-define="QUANDO_MAC_DIAGNOSTICS=${QUANDO_MAC_DIAGNOSTICS:-false}"
# Prepare explicitly: Xcode's scheme pre-action can leave an incomplete cached
# framework after relocating DerivedData. Use Flutter's own engine unpack step.
flutter assemble --output="$derived/Build/Products/Release/" \
  -dTargetPlatform=darwin -dBuildMode=release -dDarwinArchs=arm64 release_unpack_macos
provisioning=()
signing=()
if [[ ${QUANDO_MAC_AUTOMATIC_SIGNING:-false} == true ]]; then
  signing+=("CODE_SIGN_IDENTITY=${QUANDO_MAC_SIGNING_IDENTITY:-Apple Development}" "CODE_SIGN_STYLE=Automatic" 'PROVISIONING_PROFILE_SPECIFIER=')
  provisioning+=(-allowProvisioningUpdates)
else
  signing+=("CODE_SIGN_IDENTITY=${QUANDO_MAC_SIGNING_IDENTITY:--}" "CODE_SIGN_STYLE=Manual" "PROVISIONING_PROFILE_SPECIFIER=${QUANDO_MAC_PROVISIONING_PROFILE:-}")
fi
if [[ -n ${QUANDO_MAC_TEAM:-} ]]; then
  mac_app_prefix=${QUANDO_MAC_APP_IDENTIFIER_PREFIX:-"$QUANDO_MAC_TEAM."}
  signing+=("DEVELOPMENT_TEAM=$QUANDO_MAC_TEAM" "AppIdentifierPrefix=$mac_app_prefix")
fi
xcodebuild -workspace macos/Runner.xcworkspace -scheme Runner -configuration Release \
  -disableAutomaticPackageResolution -skipPackageUpdates \
  -derivedDataPath "$derived" -destination 'platform=macOS,arch=arm64' \
  ARCHS=arm64 ONLY_ACTIVE_ARCH=YES MACOSX_DEPLOYMENT_TARGET=13.0 "${provisioning[@]}" "${signing[@]}" build
source="$derived/Build/Products/Release/$name.app"
codesign --verify --deep --strict "$source"
audio="$source/Contents/Frameworks/App.framework/Resources/flutter_assets/assets/sounds"
test -s "$audio/classic_beep.wav"
afinfo "$audio/classic_beep.wav" > /dev/null
for sound in "$audio"/gentle_*.m4a; do afinfo "$sound" > /dev/null; done
ditto "$source" "$out/$name.app"
shasum -a 256 "$out/$name.app/Contents/MacOS/$name" > "$out/$edition.sha256"
git rev-parse HEAD > "$out/$edition.source-commit"
