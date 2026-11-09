#!/usr/bin/env bash
# Select branding for the native Mac runner; Dart still needs QUANDO_EDITION.
set -euo pipefail
cd "$(dirname "$0")/.."
case "${1:-}" in
  quando) bundle=com.dendrito.quando.macos; name='Quando?'; icon=AppIcon ;;
  kodesh) bundle=com.dendrito.quando.kodesh; name='Matai?'; icon=AppIcon-Matai ;;
  mine) bundle=com.dendrito.quando.mine; name='Quando Mine'; icon=AppIcon ;;
  *) echo "usage: $0 quando|kodesh|mine" >&2; exit 2 ;;
esac
python3 - "$bundle" "$name" "$icon" <<'PY'
from pathlib import Path
import sys, re
bundle, name, icon = sys.argv[1:]
p = Path('macos/Runner/Configs/AppInfo.xcconfig')
p.write_text(f'PRODUCT_NAME = {name}\nPRODUCT_BUNDLE_IDENTIFIER = {bundle}\nPRODUCT_COPYRIGHT = Copyright © 2026 Dendrito. All rights reserved.\nQUANDO_APP_ICON = {icon}\n')
p = Path('macos/Runner.xcodeproj/project.pbxproj')
s = p.read_text()
s = re.sub(r'TEST_HOST = "[^"\n]+";', lambda _: f'TEST_HOST = "$(BUILT_PRODUCTS_DIR)/{name}.app/Contents/MacOS/{name}";', s)
s = re.sub(r'MACOSX_DEPLOYMENT_TARGET = [0-9.]+;', 'MACOSX_DEPLOYMENT_TARGET = 13.0;', s)
p.write_text(s)
PY
