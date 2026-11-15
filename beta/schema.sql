-- Beta data. Private: lives in Cloudflare D1, never in the repo.
CREATE TABLE IF NOT EXISTS signups (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  email TEXT NOT NULL UNIQUE,
  platform TEXT NOT NULL,            -- android | iphone | ipad | mac
  added INTEGER NOT NULL DEFAULT 0,  -- 1 once added to the Google Group / TestFlight
  created_at INTEGER NOT NULL
);
CREATE TABLE IF NOT EXISTS feedback (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  kind TEXT NOT NULL,                -- bug | idea | love | survey
  body TEXT NOT NULL DEFAULT '',     -- survey: very | somewhat | not
  severity INTEGER,                  -- bugs only: 1 missed alarm or data loss, 2 broken, 3 cosmetic
  status TEXT NOT NULL DEFAULT 'new',-- new | now | next | later | wont | done
  platform TEXT, version TEXT, contact TEXT,
  created_at INTEGER NOT NULL
);
-- Anonymous opt-in events from the app. install_id is a random id made on the phone, not linked to the email.
CREATE TABLE IF NOT EXISTS events (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  install_id TEXT NOT NULL,
  type TEXT NOT NULL,                -- install | first_alarm | open | crash
  platform TEXT, version TEXT, detail TEXT,
  created_at INTEGER NOT NULL
);
CREATE INDEX IF NOT EXISTS ev_install ON events(install_id, type);
