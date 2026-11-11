"""Builds test/fixtures/massive_alarms.json from Amazon MASSIVE 1.1.

MASSIVE (CC BY 4.0, https://github.com/alexa/massive) holds the same voice
assistant requests translated into 51 languages. We keep the alarm ones in
Quando?'s languages and work out what each English request means (time,
day, "in 20 minutes") from its labelled parts, so every translation can be
checked against the same answer.

Usage: python3 tool/massive/build_fixture.py <massive>/1.1/data
"""
import json
import re
import sys
from pathlib import Path

LOCALES = {
    'en': 'en-US', 'pt': 'pt-PT', 'es': 'es-ES', 'fr': 'fr-FR', 'de': 'de-DE', 'it': 'it-IT',
    'nl': 'nl-NL', 'pl': 'pl-PL', 'ru': 'ru-RU', 'tr': 'tr-TR', 'ar': 'ar-SA', 'he': 'he-IL',
    'hi': 'hi-IN', 'id': 'id-ID', 'ja': 'ja-JP', 'ko': 'ko-KR', 'zh': 'zh-CN', 'zh_Hant': 'zh-TW',
    'vi': 'vi-VN',
}  # Ukrainian is not in MASSIVE.

UNITS = {w: i for i, w in enumerate(
    'zero one two three four five six seven eight nine ten eleven twelve thirteen fourteen '
    'fifteen sixteen seventeen eighteen nineteen'.split())}
TENS = {'twenty': 20, 'thirty': 30, 'forty': 40, 'fifty': 50}
DAYS = {d: i + 1 for i, d in enumerate('monday tuesday wednesday thursday friday saturday sunday'.split())}
MONTHS = {m: i + 1 for i, m in enumerate(
    'january february march april may june july august september october november december'.split())}
ORD = {'first': 1, 'second': 2, 'third': 3, 'fourth': 4, 'fifth': 5, 'sixth': 6, 'seventh': 7, 'eighth': 8,
       'ninth': 9, 'tenth': 10, 'eleventh': 11, 'twelfth': 12, 'thirteenth': 13, 'fourteenth': 14,
       'fifteenth': 15, 'sixteenth': 16, 'seventeenth': 17, 'eighteenth': 18, 'nineteenth': 19,
       'twentieth': 20, 'thirtieth': 30}


def number(words):
    """'six thirty' -> [6, 30]; 'five hundred and thirty' -> [530]."""
    out, cur, any_ = [], 0, False
    for w in words:
        if w == 'and':
            continue
        if w in UNITS and (not any_ or cur % 10 == 0 and cur >= 20 and UNITS[w] < 10):
            cur += UNITS[w]; any_ = True
        elif w in TENS and (not any_ or cur >= 100):
            cur += TENS[w]; any_ = True
        elif w == 'hundred' and any_:
            cur *= 100
        elif w == 'thousand' and any_:
            cur *= 1000
        elif w in UNITS or w in TENS:
            out.append(cur); cur = UNITS.get(w, TENS.get(w)); any_ = True
        else:
            return None
    if any_:
        out.append(cur)
    return out or None


def clock(text, timeofday):
    t = text.replace('p. m.', 'pm').replace('a. m.', 'am').replace('o\'clock', '').strip()
    if t == 'midnight':
        return {'hour': 0, 'minute': 0}
    if t == 'noon':
        return {'hour': 12, 'minute': 0}
    half = None
    if t.endswith(' am'):
        half, t = 'am', t[:-3]
    elif t.endswith(' pm'):
        half, t = 'pm', t[:-3]
    elif timeofday in ('morning', 'next morning'):
        half = 'am'
    elif timeofday in ('evening', 'afternoon', 'night', 'this evening'):
        half = 'pm'
    n = number(t.split())
    if n is None:
        return None
    if len(n) == 1 and n[0] >= 100:
        h, m = divmod(n[0], 100)
    elif len(n) == 1:
        h, m = n[0], 0
    elif len(n) == 2:
        h, m = n
    else:
        return None
    if h > 23 or m > 59:
        return None
    if half == 'pm' and h < 12:
        h += 12
    if half == 'am' and h == 12:
        h = 0
    r = {'hour': h, 'minute': m}
    if half is None and h <= 12:
        r['halfDayUnsure'] = True
    return r


def duration(text):
    t = re.sub(r'\b(from now|after|in|time)\b', ' ', text.replace("hour's", 'hour')).split()
    t = ' '.join(t)
    if t in ('half an hour', 'half hour'):
        return 30
    m = re.fullmatch(r'(an?|[a-z ]+?) (hour|hours|minute|minutes)', t)
    if not m:
        return None
    n = 1 if m.group(1) in ('a', 'an') else (number(m.group(1).split()) or [None])[0]
    if n is None:
        return None
    return n * 60 if m.group(2).startswith('hour') else n


def meaning(slots):
    """What an English request asks for, or None when we can't be sure."""
    e = {}
    tod = slots.get('timeofday')
    if tod == 'noon' and 'time' not in slots:
        e.update(hour=12, minute=0)
    if 'time' in slots:
        t = slots['time']
        if re.search(r'from now|^(after|in) |minutes?$|hours?$|hour\'s time', t) and not re.search(r'before|after that|meal|today', t):
            d = duration(t)
            if d is None:
                return None
            e['after'] = d
        else:
            c = clock(t, tod)
            if c is None:
                return None
            e.update(c)
    date = slots.get('date', '')
    freq = slots.get('general_frequency', '')
    if date:
        d = date.replace("'s", '').replace('tomorrows', 'tomorrow')
        if d == 'tomorrow' or d.startswith('tomorrow '):
            e['dayOffset'] = 1
        elif d == 'today':
            e['dayOffset'] = 0
        elif d in ('everyday', 'all days'):
            e['days'] = [1, 2, 3, 4, 5, 6, 7]
        elif d.rstrip('s') in DAYS:
            day = DAYS[d.rstrip('s')]
            if d.endswith('s'):
                e['days'] = [day]
            else:
                e['weekday'] = day
        elif d.startswith('next ') and d[5:] in DAYS:
            e['weekday'] = DAYS[d[5:]]
        else:
            parts = d.split()
            day = next((ORD[p] for p in parts if p in ORD), None)
            if day is None and len(parts) > 1 and parts[0] in TENS and parts[1] in ORD:
                day = TENS[parts[0]] + ORD[parts[1]]
            month = next((MONTHS[p] for p in parts if p in MONTHS), None)
            if day and month and 'two' not in parts[2:]:
                e['date'] = [month, day]
            else:
                return None
    if freq:
        if freq == 'every weekday':
            e['days'] = [1, 2, 3, 4, 5]
        elif freq in ('seven days a week', 'every morning'):
            e['days'] = [1, 2, 3, 4, 5, 6, 7]
        else:
            return None
    if not any(k in e for k in ('hour', 'after')):
        return None
    return e


def main(data):
    data = Path(data)
    rows = {}
    for lang, loc in LOCALES.items():
        for line in open(data / f'{loc}.jsonl', encoding='utf-8'):
            d = json.loads(line)
            if d['scenario'] != 'alarm':
                continue
            r = rows.setdefault(d['id'], {'id': d['id'], 'intent': d['intent'], 'text': {}})
            r['text'][lang] = d['utt']
            if lang == 'en':
                r['slots'] = dict(re.findall(r'\[(\w+) : ([^\]]+)\]', d['annot_utt']))
    out = []
    for r in sorted(rows.values(), key=lambda r: int(r['id'])):
        item = {'id': r['id'], 'intent': r['intent'], 'text': r['text']}
        if r['intent'] == 'alarm_set':
            m = meaning(r.get('slots', {}))
            if m is None:
                continue
            item['expect'] = m
        out.append(item)
    dest = Path(__file__).resolve().parents[2] / 'test' / 'fixtures' / 'massive_alarms.json'
    dest.parent.mkdir(exist_ok=True)
    dest.write_text(json.dumps({
        'source': 'Amazon MASSIVE 1.1, CC BY 4.0, https://github.com/alexa/massive',
        'items': out,
    }, ensure_ascii=False, indent=0) + '\n', encoding='utf-8')
    by = {}
    for i in out:
        by[i['intent']] = by.get(i['intent'], 0) + 1
    print(dest, by)


if __name__ == '__main__':
    main(sys.argv[1])
