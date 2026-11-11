#!/usr/bin/env python3
"""Builds lib/features/quotes/data/quote_bank.dart from the text files here.

meta.txt     one line per shared quote: id source tags [orig]
             tags are comma separated (see lib/features/quotes/domain/quote.dart).
             orig = the language it was first said in; those words are shown
             under the translation (orig.txt holds Latin and Yiddish).
<lang>.txt   id = text | author      a translation of a shared quote
             +source tags = text | author   a quote only for this language

A shared quote with no line in a language is shown there in its original words.
Run: python3 tool/quotes/build.py
"""
import os, re, subprocess, sys

HERE = os.path.dirname(os.path.abspath(__file__))
OUT = os.path.join(HERE, '..', '..', 'lib', 'features', 'quotes', 'data', 'quote_bank.dart')
SOURCES = {'songs', 'movies', 'literature', 'tanakh', 'sages', 'siddur', 'speeches', 'philosophy', 'proverbs'}
SLOT = {'any', 'morning', 'day', 'evening', 'night'}
TAG = re.compile(r'^(any|morning|day|evening|night|@morning|@day|@evening|@night|idle|erev|mon|tue|wed|thu|fri|sat|sun|'
                 r'jan|feb|mar|apr|may|jun|jul|aug|sep|oct|nov|dec|\d\d-\d\d|'
                 r'roshhashana|yomkippur|sukkot|simchattorah|chanukah[1-8]?|tishabav|tubishvat|purim|pesach|shavuot|carnaval|yomhaatzmaut|yomyerushalayim|place:\w+|\d\d-\d\d\.\.\d\d-\d\d|event:\w+)$')

# ---- Guard rails ----
# Every quote must pass these, or the build stops and names the line.
MAX_LEN = 150
# Numbers people read as omens, in digits or words.
OMENS = [r'\b666\b', r'\b13\b', r'seiscentos e sessenta', r'six hundred (and )?sixty', r'sechshundert(und)?sechzig',
         r'шестьсот шестьдесят', r'sexcent']
# Killing, suicide, hell and the devil, per language. An alarm clock should not
# greet anyone with these. Death itself is allowed when the line is warm or fitting
# (Curió, 2026-11-11), so each quote with death in it is judged by a person. Latin-script words match whole words or stems.
DARK = {
    'en': r'\b(kill\w*|suicid\w*|hell|devil|satan)\b',
    'pt': r'\b(mata\w*|suicíd\w*|inferno|diabo|satanás)\b',
    'es': r'\b(mata\w*|suicid\w*|infierno|diablo)\b',
    'fr': r'\b(tue[rz]?|suicid\w*|enfer|diable)\b',
    'de': r'\b(töt\w*|hölle|teufel)\b',
    'it': r'\b(uccid\w*|inferno|diavolo)\b',
    'nl': r'\b(hel|duivel)\b',
    'pl': r'\b(zabi\w*|piekł\w*|diab\w*)\b',
    'ru': r'(убий|\bубит|\bад\b|дьявол)',
    'uk': r'(вбив|пекл|дияв)',
    'tr': r'\b(öldür\w*|cehennem|şeytan)\b',
    'ar': r'(قتل|جحيم|شيطان)',
    'he': r'(הָרַג|הרג|גֵּיהִנֹּם|גיהנום|שָּׂטָן|שטן)',
    'hi': r'(हत्या|नरक|शैतान)',
    'id': r'\b(bunuh\w*|neraka|setan)\b',
    'ja': r'(殺|地獄|悪魔)',
    'ko': r'(살인|지옥|악마)',
    'zh': r'(杀|殺|地狱|地獄|魔鬼)',
    'zh_Hant': r'(殺|地獄|魔鬼)',
    'vi': r'\b(giết|địa ngục|quỷ)\b',
}
# No Christian religious figures, scripture or holidays (Curió, 2026-11-04).
CHRISTIAN_BY = re.compile(r'((?<![\w-])(saint|santo|santa|san|st\.|sankt|św\.|святой|святий|aziz|القديس|पोप|pope|papa|papst|apostle|apóstolo|reverend|reverendo|pastor|padre|father)(?![\w-])'
                          r'|jesus|jesús|jésus|cristo|christ|христ|المسيح|ישו|यीशु|イエス|예수|耶稣|耶穌|chúa giê-su'
                          r'|augustin|agostin|agustín|aquin|luther(?!\s*king)|calvin|francis of assisi|thomas à kempis|bonhoeffer'
                          r'|(matthew|mark|luke|john|mateus|marcos|lucas|joão|mateo|juan|romans|romanos|corinthians|coríntios|revelation|apocalipse)\s+\d)', re.I)
CHRISTIAN_TEXT = re.compile(r'\b(christmas|xmas|natal|navidad|noël|weihnacht\w*|natale|kerst\w*|boże narodzenie|рождеств\w*|різдв\w*|noel|easter|ostern|pâques|pascua|páscoa|pasqua|jesus|jesús|cristo|christ|holy spirit|espírito santo)\b', re.I)
CHRISTIAN_WORDS = re.compile(r'(クリスマス|크리스마스|圣诞|聖誕|عيد الميلاد|חג המולד|क्रिसमस|giáng sinh|natal)', re.I)

# No quotes from people known for antisemitism (Curió, 2026-11-04). Match on the
# credit, in any script the files use. Add names here rather than deleting lines.
BLOCKED_PEOPLE = re.compile(r'(roger waters|pink floyd|baudelaire|virginia woolf|wagner|ezra pound|t\. ?s\. eliot|henry ford|céline|celine'
                            r'|dostoevsk|dostoïevski|dostojewski|достоевск|voltaire|karl marx|roald dahl|knut hamsun|coco chanel|kanye|\bye\b'
                            r'|mel gibson|farrakhan|alice walker|ahmadinejad|martin luther(?!\s*king)|heidegger|houston stewart chamberlain'
                            r'|פינק פלויד|וולף|بينك فلويد|فرجينيا وولف|пинк флойд|вирджиния вулф|вірджинія вулф)', re.I)

# Shabbat stays out of view for people who did not ask for Jewish sources.
EREV_SOURCES = {'tanakh', 'sages', 'siddur'}

problems = []

def guard(lang, where, text, by, source, tags):
    low = text.lower()
    if len(text) > MAX_LEN:
        problems.append(f'{where}: longer than {MAX_LEN} characters')
    if re.search(r'\d', text):
        problems.append(f'{where}: digits in the quote (spell numbers out, or leave it out)')
    for pat in OMENS:
        if re.search(pat, low) or re.search(pat, by.lower()):
            problems.append(f'{where}: omen number ({pat})')
    dark = DARK.get(lang)
    hit = dark and re.search(dark, low)
    if hit:
        problems.append(f'{where}: dark word "{hit.group(0).strip()}"')
    if BLOCKED_PEOPLE.search(by):
        problems.append(f'{where}: author is on the antisemitism blocklist')
    if CHRISTIAN_BY.search(by) or CHRISTIAN_TEXT.search(text) or CHRISTIAN_WORDS.search(text):
        problems.append(f'{where}: Christian religious figure, scripture or holiday')
    if not by.strip():
        problems.append(f'{where}: no author')
    if re.search(r'\d', by) and source not in EREV_SOURCES:
        problems.append(f'{where}: numbers in the credit are only for scripture references')
    if 'erev' in tags.split(',') and source not in EREV_SOURCES:
        problems.append(f'{where}: the erev tag is only for Tanakh and sages')

def dart(s):
    return "'" + s.replace('\\', '\\\\').replace("'", "\\'").replace('$', '\\$') + "'"

def check_tags(tags, where):
    for t in tags.split(','):
        if not TAG.match(t):
            sys.exit(f'{where}: unknown tag {t}')

meta = {}
for n, line in enumerate(open(os.path.join(HERE, 'meta.txt'), encoding='utf-8'), 1):
    line = line.strip()
    if not line or line.startswith('#'):
        continue
    parts = line.split()
    qid, source, tags = parts[0], parts[1], parts[2]
    if source not in SOURCES:
        sys.exit(f'meta.txt:{n}: unknown source {source}')
    check_tags(tags, f'meta.txt:{n}')
    meta[qid] = (source, tags, parts[3] if len(parts) > 3 else None)

def parse(lang):
    shared, local = {}, []
    for n, line in enumerate(open(os.path.join(HERE, lang + '.txt'), encoding='utf-8'), 1):
        line = line.rstrip('\n')
        if not line.strip() or line.startswith('#'):
            continue
        head, _, rest = line.partition(' = ')
        text, _, by = rest.rpartition(' | ')
        if not text or not by:
            sys.exit(f'{lang}.txt:{n}: expected "... = text | author"')
        if head.startswith('+'):
            source, tags = head[1:].split()
            if source not in SOURCES:
                sys.exit(f'{lang}.txt:{n}: unknown source {source}')
            check_tags(tags, f'{lang}.txt:{n}')
            guard(lang, f'{lang}.txt:{n}', text, by, source, tags)
            local.append((text, by, source, tags))
        else:
            if head not in meta:
                sys.exit(f'{lang}.txt:{n}: {head} is not in meta.txt')
            src, tg, _ = meta[head]
            guard(lang, f'{lang}.txt:{n}', text, by, src, tg)
            shared[head] = (text, by)
    return shared, local

langs = sorted(f[:-4] for f in os.listdir(HERE) if f.endswith('.txt') and f not in ('meta.txt', 'orig.txt'))
parsed = {lang: parse(lang) for lang in langs}
extra = {}
for line in open(os.path.join(HERE, 'orig.txt'), encoding='utf-8'):
    line = line.rstrip('\n')
    if line.strip() and not line.startswith('#'):
        qid, _, rest = line.partition(' = ')
        text, _, lang = rest.rpartition(' | ')
        extra[qid] = (lang, text)

def original(qid):
    """(language, words) the quote was first said in, if known."""
    o = meta[qid][2]
    if o is None:
        return None
    if o in parsed and qid in parsed[o][0]:
        return o, parsed[o][0][qid][0]
    if qid in extra and extra[qid][0] == o:
        return extra[qid]
    problems.append(f'meta.txt: {qid} says it was first in {o}, but no {o} words were found')
    return None

def q(text, by, source, tags, orig=None):
    o = f', {dart(orig)}' if orig else ''
    return f'    Quote({dart(text)}, {dart(by)}, QuoteSource.{source}, {dart(tags)}{o}),'

out = ['// Generated by tool/quotes/build.py from tool/quotes/*.txt. Do not edit by hand.', '',
       "import '../domain/quote.dart';", '',
       '/// Quotes per language: translations of the shared set (with the original',
       '/// words when they differ) plus quotes only for that language.',
       'const quoteBank = <String, List<Quote>>{']
counts = {}
for lang in langs:
    shared, local = parsed[lang]
    en_shared = parsed['en'][0]
    seen = set()
    out.append(f"  '{lang}': [")
    for qid, (source, tags, o) in meta.items():
        orig = original(qid)
        if qid in shared:
            text, by = shared[qid]
            words = orig[1] if orig and orig[0] != lang and orig[1] != text else None
        elif orig and qid in en_shared:
            # No translation here: show the original words, credited as in English.
            text, by, words = orig[1], en_shared[qid][1], None
        else:
            continue
        if text in seen:
            continue
        seen.add(text)
        out.append(q(text, by, source, tags, words))
    for text, by, source, tags in local:
        if text in seen:
            continue
        seen.add(text)
        out.append(q(text, by, source, tags))
    out.append('  ],')
    counts[lang] = len(seen)
out.append('};')
if problems:
    print('\n'.join(problems))
    sys.exit(f'{len(problems)} quotes broke the guard rails; nothing was written.')
open(OUT, 'w', encoding='utf-8').write('\n'.join(out) + '\n')
# CI checks formatting, so format the generated file the same way.
try:
    subprocess.run(['dart', 'format', OUT], check=True, capture_output=True)
except (OSError, subprocess.CalledProcessError):
    print('Run `dart format lib/features/quotes/data/quote_bank.dart` before committing.')
print(', '.join(f'{k} {v}' for k, v in counts.items()))
