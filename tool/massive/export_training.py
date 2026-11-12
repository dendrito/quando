"""Turns test/fixtures/massive_alarms.json into training pairs for a small
on-device model (the AlarmAi backup in lib/features/assistant/domain/alarm_ai.dart):
one JSON line per sentence and language, with the answer in the same
fields as AlarmRequest. Amazon MASSIVE is CC BY 4.0: keep the credit with
anything trained on it.

Usage: python3 tool/massive/export_training.py out.jsonl
"""
import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]


def target(item):
    if item['intent'] == 'alarm_remove':
        return {'action': 'remove'}
    if item['intent'] == 'alarm_query':
        return {'question': True}
    e = item['expect']
    t = {}
    if 'after' in e:
        t['afterMinutes'] = e['after']
    if 'hour' in e:
        t['hour'], t['minute'] = e['hour'], e['minute']
        if e.get('halfDayUnsure'):
            t['halfDayUnsure'] = True
    for k in ('dayOffset', 'days'):
        if k in e:
            t[k] = e[k]
    if 'weekday' in e:
        t['onWeekday'] = e['weekday']
    if 'date' in e:
        t['month'], t['dayOfMonth'] = e['date']
    return t


def main(out):
    data = json.loads((ROOT / 'test/fixtures/massive_alarms.json').read_text(encoding='utf-8'))
    n = 0
    with open(out, 'w', encoding='utf-8') as f:
        for item in data['items']:
            t = target(item)
            for lang, text in item['text'].items():
                f.write(json.dumps({'lang': lang, 'text': text, 'target': t}, ensure_ascii=False) + '\n')
                n += 1
    print(f'{n} pairs → {out} ({data["source"]})')


if __name__ == '__main__':
    main(sys.argv[1] if len(sys.argv) > 1 else 'massive_training.jsonl')
