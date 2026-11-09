#!/usr/bin/env bash
# Select an edition before building; safe to switch repeatedly in one checkout.
set -euo pipefail
cd "$(dirname "$0")/.."
case "${1:-}" in
  quando) bundle=com.dendrito.quando.ios; name='Quando?'; icon=AppIcon ;;
  kodesh) bundle=com.dendrito.quando.kodesh; name='Matai?'; icon=AppIcon-Matai ;;
  mine) bundle=com.dendrito.quando.mine; name='Quando Mine'; icon=AppIcon ;;
  *) echo "usage: $0 quando|kodesh|mine" >&2; exit 2 ;;
esac
python3 - "$bundle" "$name" "$icon" <<'PYTHON'
from pathlib import Path
import re, sys
bundle, name, icon = sys.argv[1:]
p = Path('ios/Runner.xcodeproj/project.pbxproj')
s = p.read_text()
s = re.sub(r'PRODUCT_BUNDLE_IDENTIFIER = com\.dendrito\.quando(?:\.(?:ios|kodesh|mine))?;',
           f'PRODUCT_BUNDLE_IDENTIFIER = {bundle};', s)
s = re.sub(r'ASSETCATALOG_COMPILER_APPICON_NAME = (?:AppIcon|"AppIcon-Matai");',
           f'ASSETCATALOG_COMPILER_APPICON_NAME = "{icon}";' if '-' in icon else
           f'ASSETCATALOG_COMPILER_APPICON_NAME = {icon};', s)
p.write_text(s)
p = Path('ios/Runner/Info.plist')
s = p.read_text()
s = re.sub(r'(<key>CFBundleDisplayName</key>\s*<string>)[^<]*(</string>)',
           lambda m: m[1] + name + m[2], s)
p.write_text(s)
PYTHON
echo "iOS project set to $name ($bundle)"
