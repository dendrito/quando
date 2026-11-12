#!/usr/bin/env bash
# Build and install the apps, printing one line per step instead of the full
# build log, with a live progress line on a terminal. On failure it prints only the error lines and the log's path.
#   tool/ship.sh quando|kodesh|mine|all mac|ipad|ipad-on-mac|android|windows|all [--no-install]
# ipad-on-mac builds the iPad app for this Mac (Designed for iPad); it is never installed.
# 'all' means mac, ipad and android. Windows builds only on a Windows machine.
# Logs: build/ship/*.log. Override with QUANDO_MAC_TEAM, QUANDO_IPAD_ID.
set -euo pipefail
cd "$(dirname "$0")/.."
export LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8

usage() { echo 'usage: tool/ship.sh quando|kodesh|mine|all mac|ipad|ipad-on-mac|android|windows|all [--no-install]' >&2; exit 2; }
[[ $# -ge 2 && $# -le 3 ]] || usage
case "$1" in quando|kodesh|mine) editions=$1 ;; all) editions='quando kodesh mine' ;; *) usage ;; esac
case "$2" in mac|ipad|ipad-on-mac|android|windows) targets=$2 ;; all) targets='mac ipad android' ;; *) usage ;; esac
install=true
if [[ $# -eq 3 ]]; then [[ $3 == --no-install ]] || usage; install=false; fi

team=${QUANDO_MAC_TEAM:-PKZ22BXX3F}
ipad=${QUANDO_IPAD_ID:-00008103-001A69A022D9001E}
logs=$PWD/build/ship
mkdir -p "$logs"

# Progress: every step is numbered [n/total]. On a terminal a live line shows a
# bar, the step, elapsed time and the log's latest line, refreshed each second.
# The counter lives in a file because ship_ipad runs in a subshell.
stepfile=$logs/.step
echo 0 > "$stepfile"
total=1
[[ $targets == *ipad* ]] && total=$((total + 1))
for t in $targets; do
  for e in $editions; do
    if [[ $t == ipad || $t == ipad-on-mac ]]; then total=$((total + 2)); else total=$((total + 1)); fi
    if $install && [[ $t != ipad-on-mac ]]; then total=$((total + 1)); fi
  done
done
t0=$SECONDS

fmt() { printf '%d:%02d' $(($1 / 60)) $(($1 % 60)); }

bar() { # bar <done> <total>: 20-cell bar
  local n=$1 of=$2 w=20 i out=''
  local fill=$((n * w / of))
  for ((i = 0; i < w; i++)); do if ((i < fill)); then out+='#'; else out+='.'; fi; done
  printf '[%s] %d%%' "$out" $((n * 100 / of))
}

# run <label> <log name> <command...>: one live line while it runs, then ok/FAIL.
run() {
  local label=$1 log=$logs/$2.log start=$SECONDS n spin='|/-\' i=0 last cols line
  shift 2
  n=$(( $(cat "$stepfile") + 1 )); echo "$n" > "$stepfile"
  "$@" > "$log" 2>&1 &
  local pid=$!
  if [[ -t 1 ]]; then
    while kill -0 "$pid" 2>/dev/null; do
      cols=$(tput cols 2>/dev/null || echo 80)
      last=$(tail -n 1 "$log" 2>/dev/null | tr -cd '[:print:]' | cut -c1-60)
      printf -v line '%s %s step %d/%d  %s  %s  total %s | %s' "${spin:$((i % 4)):1}" \
        "$(bar $((n - 1)) "$total")" "$n" "$total" "$label" "$(fmt $((SECONDS - start)))" \
        "$(fmt $((SECONDS - t0)))" "$last"
      # Clip to one terminal row: a wrapped line cannot be redrawn in place.
      printf '\r\033[K%s' "${line:0:$((cols - 1))}"
      i=$((i + 1)); sleep 1
    done
    printf '\r\033[K'
  fi
  if wait "$pid"; then
    echo "ok    [$n/$total] $label ($(fmt $((SECONDS - start))))"
    return 0
  fi
  echo "FAIL  [$n/$total] $label ($(fmt $((SECONDS - start))))"
  { grep -E 'error:|Error:|FAILED|Exception|Could not' "$log" || tail -15 "$log"; } | sort -u | head -20 | cut -c1-300
  echo "full log: $log"
  exit 1
}

fetch_spotify() {
  local dir target tmp
  dir=$(python3 -c "import json,urllib.parse; c=json.load(open('.dart_tool/package_config.json')); print([urllib.parse.unquote(p['rootUri'][7:]) for p in c['packages'] if p['name']=='spotify_sdk_ios'][0])")
  target=$dir/ios/spotify_sdk_ios/ios-sdk
  [[ -d $target/SpotifyiOS.xcframework ]] && return 0
  tmp=$(mktemp -d)
  git clone -q --depth 1 --branch v5.0.1 https://github.com/spotify/ios-sdk "$tmp/sdk"
  rm -rf "$target" && mkdir -p "$target"
  cp -R "$tmp/sdk/SpotifyiOS.xcframework" "$target/"
}

ship_mac() {
  local e=$1
  run "$e mac build" "$e-mac-build" env QUANDO_MAC_OUTPUT="$logs/mac" QUANDO_MAC_TEAM="$team" \
    QUANDO_MAC_AUTOMATIC_SIGNING=true tool/build_macos.sh "$e"
  if $install; then run "$e mac install" "$e-mac-install" python3 tool/install_macos.py "$e" "$logs/mac"; fi
}

# Android: the flavor and QUANDO_EDITION always carry the same edition name.
# The APK is copied to build/ship/android/. Installing needs a phone on adb.
ship_android() {
  local e=$1 apk=build/app/outputs/flutter-apk/app-$1-release.apk jdk=/opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home
  # macOS has no system Java; fall back to Homebrew's JDK 17 (the project's jvmTarget).
  if [[ -z ${JAVA_HOME:-} ]] && ! /usr/libexec/java_home > /dev/null 2>&1 && [[ -d $jdk ]]; then export JAVA_HOME=$jdk; fi
  run "$e android build" "$e-android-build" flutter build apk --release --flavor "$e" --dart-define="QUANDO_EDITION=$e"
  mkdir -p "$logs/android" && cp "$apk" "$logs/android/$e.apk"
  if $install; then run "$e android install" "$e-android-install" adb install -r "$logs/android/$e.apk"; fi
}

# iPad app for this Mac ("Designed for iPad"). Built only, never installed: the
# native Mac app avoids an iPad-on-Mac launch failure seen on this Mac, so this
# target is for trying the iPad build, not for replacing the Mac app.
ship_ipadonmac() (
  e=$1
  saved=$(mktemp -d)
  cp ios/Runner.xcodeproj/project.pbxproj ios/Runner/Info.plist "$saved/"
  trap 'cp "$saved/project.pbxproj" ios/Runner.xcodeproj/; cp "$saved/Info.plist" ios/Runner/' EXIT
  run "$e ipad-on-mac select edition" "$e-ipadmac-edition" tool/ios_edition.sh "$e"
  run "$e ipad-on-mac build" "$e-ipadmac-build" bash -c '
    flutter build ios --release --config-only --no-pub --no-tree-shake-icons --dart-define="QUANDO_EDITION=$0" &&
    xcodebuild -workspace ios/Runner.xcworkspace -scheme Runner -configuration Release \
      -derivedDataPath build/ios-on-mac -destination "platform=macOS,arch=arm64,variant=Designed for iPad" \
      -allowProvisioningUpdates DEVELOPMENT_TEAM="$1" build &&
    app=$(find build/ios-on-mac/Build/Products -maxdepth 2 -name Runner.app | head -1) &&
    test -n "$app" && mkdir -p build/ship/ipad-on-mac && rm -rf "build/ship/ipad-on-mac/$0.app" &&
    cp -R "$app" "build/ship/ipad-on-mac/$0.app"' "$e" "$team"
)

# Windows cannot be built from a Mac, and this project has no windows/ runner yet.
ship_windows() { echo 'FAIL  windows build is not set up' >&2; exit 1; }

# Runs in a subshell so the trap puts the edition's iOS project edits back.
ship_ipad() (
  e=$1
  saved=$(mktemp -d)
  cp ios/Runner.xcodeproj/project.pbxproj ios/Runner/Info.plist "$saved/"
  trap 'cp "$saved/project.pbxproj" ios/Runner.xcodeproj/; cp "$saved/Info.plist" ios/Runner/' EXIT
  run "$e ipad select edition" "$e-ipad-edition" tool/ios_edition.sh "$e"
  run "$e ipad build" "$e-ipad-build" flutter build ios --release --no-tree-shake-icons --dart-define="QUANDO_EDITION=$e"
  # Keep each edition's app: the next edition's build overwrites build/ios/iphoneos/Runner.app.
  mkdir -p "$logs/ipad" && rm -rf "$logs/ipad/$e.app" && cp -R build/ios/iphoneos/Runner.app "$logs/ipad/$e.app"
  if $install; then
    run "$e ipad install" "$e-ipad-install" xcrun devicectl device install app --device "$ipad" build/ios/iphoneos/Runner.app
  fi
)

if [[ $targets == *windows* ]]; then
  if [[ $(uname -s) != MINGW* && $(uname -s) != MSYS* ]]; then
    echo 'FAIL  windows builds need a Windows machine (run this script there in Git Bash)' >&2; exit 1
  fi
  [[ -d windows ]] || { echo 'FAIL  no windows/ folder: the project has no Windows runner yet' >&2; exit 1; }
fi
if $install && [[ $targets == *android* ]] && ! adb devices 2>/dev/null | awk 'NR>1 && $2=="device"' | grep -q .; then
  echo 'FAIL  no Android phone on adb: connect it with USB debugging on, or add --no-install' >&2
  exit 1
fi

# An unreachable iPad should fail now, not after a long build.
if $install && [[ " $targets " == *' ipad '* ]] && xcrun devicectl list devices 2>/dev/null | grep "$ipad" | grep -q unavailable; then
  echo 'FAIL  iPad is unavailable: unlock it and connect it, or add --no-install' >&2
  exit 1
fi

echo "source $(git rev-parse --short HEAD) on $(git branch --show-current)"
run 'flutter pub get' pub-get flutter pub get
if [[ $targets == *ipad* ]]; then run 'spotify framework' spotify fetch_spotify; fi
for e in $editions; do
  for t in $targets; do
    fn=${t//-/}; "ship_$fn" "$e"
  done
done
echo "done: $total steps in $(fmt $((SECONDS - t0)))"
