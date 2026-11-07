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
flutter build macos --release --config-only --no-pub --dart-define="QUANDO_EDITION=$edition"
signing=("CODE_SIGN_IDENTITY=${QUANDO_MAC_SIGNING_IDENTITY:--}" "CODE_SIGN_STYLE=Manual" 'PROVISIONING_PROFILE_SPECIFIER=')
if [[ -n ${QUANDO_MAC_TEAM:-} ]]; then signing+=("DEVELOPMENT_TEAM=$QUANDO_MAC_TEAM"); fi
xcodebuild -workspace macos/Runner.xcworkspace -scheme Runner -configuration Release \
  -derivedDataPath "$derived" -destination 'platform=macOS,arch=arm64' \
  ARCHS=arm64 ONLY_ACTIVE_ARCH=YES MACOSX_DEPLOYMENT_TARGET=13.0 "${signing[@]}" build
source="$derived/Build/Products/Release/$name.app"
codesign --verify --deep --strict "$source"
ditto "$source" "$out/$name.app"
shasum -a 256 "$out/$name.app/Contents/MacOS/$name" > "$out/$edition.sha256"
git rev-parse HEAD > "$out/$edition.source-commit"
