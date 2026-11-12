#!/usr/bin/env python3
"""Install a built Mac edition into /Applications, keeping a backup and user data.

  tool/install_macos.py quando|kodesh|mine <folder holding the built .app>

Keeps the outer app folder so existing shortcuts survive, rolls back if the copy
fails, and reopens the app if it was running, because Mac alarms only ring while
the app is open. Backups go to ~/Developer/quando-backups (newest 3 per edition).
QUANDO_INSTALL_ROOT installs elsewhere for testing, leaving running apps alone.
"""
from pathlib import Path
import datetime, os, plistlib, shutil, signal, subprocess, sys, time

LSREGISTER = '/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister'
NAMES = {
    'quando': ('Quando?', 'com.dendrito.quando.macos'),
    'kodesh': ('Matai?', 'com.dendrito.quando.kodesh'),
    'mine': ('Quando Mine', 'com.dendrito.quando.mine'),
}
KEEP_BACKUPS = 3

edition, built = sys.argv[1], Path(sys.argv[2])
name, bundle = NAMES[edition]
source = built / f'{name}.app'
info = plistlib.loads((source / 'Contents/Info.plist').read_bytes())
assert info['CFBundleIdentifier'] == bundle, info['CFBundleIdentifier']
assert 'MacOSX' in info['CFBundleSupportedPlatforms']
subprocess.run(['codesign', '--verify', '--deep', '--strict', str(source)], check=True)

root = Path(os.environ.get('QUANDO_INSTALL_ROOT', '/Applications'))
live = root == Path('/Applications')
target = root / source.name
backups = Path(os.environ.get('QUANDO_BACKUPS', Path.home() / 'Developer/quando-backups'))
backup_dir = backups / f"{edition}-{datetime.datetime.now():%Y%m%d-%H%M%S}"
backup_dir.mkdir(parents=True)
if target.exists():
    subprocess.run(['ditto', str(target), str(backup_dir / target.name)], check=True)


def running_pids():
    pids = []
    for line in subprocess.check_output(['ps', '-axo', 'pid=,comm='], text=True).splitlines():
        parts = line.strip().split(None, 1)
        if len(parts) != 2:
            continue
        try:
            plist = Path(parts[1]).parent.parent / 'Info.plist'
            if plistlib.loads(plist.read_bytes()).get('CFBundleIdentifier') == bundle:
                pids.append(int(parts[0]))
        except (OSError, ValueError):
            continue
    return pids


stopped = running_pids() if live else []
for pid in stopped:
    os.kill(pid, signal.SIGTERM)
if stopped:
    time.sleep(1)

target.mkdir(exist_ok=True)
retired = backup_dir / 'retired-contents'
retired.mkdir()
for child in target.iterdir():
    os.rename(child, retired / child.name)
try:
    subprocess.run(['ditto', str(source), str(target)], check=True)
    subprocess.run(['codesign', '--verify', '--deep', '--strict', str(target)], check=True)
except BaseException:
    failed = backup_dir / 'failed-contents'
    failed.mkdir()
    for child in target.iterdir():
        os.rename(child, failed / child.name)
    for child in retired.iterdir():
        os.rename(child, target / child.name)
    raise
shutil.rmtree(retired)

if live:
    subprocess.run([LSREGISTER, '-f', str(target)], check=True)
    if stopped:
        subprocess.run(['open', str(target)], check=True)

for old in sorted(backups.glob(f'{edition}-*'))[:-KEEP_BACKUPS]:
    shutil.rmtree(old)
print(f'installed {target}; backup {backup_dir}; reopened: {bool(stopped)}')
