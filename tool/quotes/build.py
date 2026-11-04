#!/usr/bin/env python3
"""Builds lib/features/quotes/data/quote_bank.dart from the text files here.

meta.txt     one line per shared quote: id source tags [!]
             tags are comma separated (see lib/features/quotes/domain/quote.dart).
             ! = the quote is shown in its original words in every language
             (English songs and films); its text lives in en.txt only.
<lang>.txt   id = text | author      a translation of a shared quote
             +source tags = text | author   a quote only for this language

A shared quote with no line in a language is left out of that language.
Run: python3 tool/quotes/build.py
"""
import os, re, sys

HERE = os.path.dirname(os.path.abspath(__file__))
OUT = os.path.join(HERE, '..', '..', 'lib', 'features', 'quotes', 'data', 'quote_bank.dart')
SOURCES = {'songs', 'movies', 'literature', 'tanakh', 'sages', 'speeches', 'philosophy', 'proverbs'}
SLOT = {'any', 'morning', 'day', 'evening', 'night'}
TAG = re.compile(r'^(any|morning|day|evening|night|@morning|@day|@evening|@night|idle|erev|mon|tue|wed|thu|fri|sat|sun|'
                 r'jan|feb|mar|apr|may|jun|jul|aug|sep|oct|nov|dec|\d\d-\d\d|'
                 r'roshhashana|yomkippur|sukkot|chanukah|tubishvat|purim|pesach|shavuot|event:\w+)$')

# ---- Guard rails ----
# Every quote must pass these, or the build stops and names the line.
MAX_LEN = 150
# Numbers people read as omens, in digits or words.
OMENS = [r'\b666\b', r'\b13\b', r'seiscentos e sessenta', r'six hundred (and )?sixty', r'sechshundert(und)?sechzig',
         r'шестьсот шестьдесят', r'sexcent']
# Death, killing, hell and the devil, per language. An alarm clock should not
# greet anyone with these. Latin-script words match whole words or stems.
DARK = {
    'en': r'\b(death|dead|die[sd]?|dying|kill\w*|suicid\w*|hell|devil|satan|grave|bur(y|ied|ies)|funeral|blood)\b',
    'pt': r'\b(mort[eo]s?|morr\w*|mata\w*|suicíd\w*|inferno|diabo|satanás|enterr\w*|túmulo|sangue|cova)\b',
    'es': r'\b(muert\w*|mor[ií]\w*|mata\w*|suicid\w*|infierno|diablo|entierr\w*|tumba|sangre)\b',
    'fr': r'\b(mort\w*|meur\w*|mourir|tue[rz]?|suicid\w*|enfer|diable|tombe(au)?|sang)\b',
    'de': r'\b(tod\w*|tot\w*|sterb\w*|stirb\w*|töt\w*|hölle|teufel|grab|begrab\w*|blut)\b',
    'it': r'\b(mort[eio]\w*|mori\w*|muor\w*|uccid\w*|inferno|diavolo|tomba|sepol\w*|sangue)\b',
    'nl': r'\b(dood|doden|sterf\w*|sterv\w*|hel|duivel|graf|begr\w*|bloed)\b',
    'pl': r'\b(śmier\w*|umr\w*|umier\w*|zabi\w*|piekł\w*|diab\w*|grób|grob\w*|krew|krwi)\b',
    'ru': r'(смерт|умер|умир|убий|\bубит|\bад\b|дьявол|могил|похорон|кров[ьи])',
    'uk': r'(смерт|помер|вмир|вбив|пекл|дияв|могил|похорон|кров)',
    'tr': r'\b(ölüm\w*|öldür\w*|cehennem|şeytan|mezar\w*|kan)\b',
    'ar': r'(\bموت|\bالموت|يموت|قتل|جحيم|شيطان|قبر|\bدم\b|الدم)',
    'he': r'(מָוֶת|מוות|מִיתָה|מיתה|יָמוּת|ימות|הָרַג|הרג|גֵּיהִנֹּם|גיהנום|שָּׂטָן|שטן|קֶבֶר|קבר|(^|\s)דָּ?ם(\s|[.,]|$))',
    'hi': r'(मृत्यु|मौत|मरना|मर जा|हत्या|नरक|शैतान|कब्र|ख़ून|खून)',
    'id': r'\b(mati|kematian|bunuh\w*|neraka|setan|kubur\w*|darah)\b',
    'ja': r'(死|殺|地獄|悪魔|墓|血)',
    'ko': r'(죽음|죽는|죽었|죽이|살인|지옥|악마|무덤)',
    'zh': r'(死|杀|殺|地狱|地獄|魔鬼|坟|墳|血)',
    'zh_Hant': r'(死|殺|地獄|魔鬼|墳|血)',
    'vi': r'\b(chết|giết|địa ngục|quỷ|mộ|máu)\b',
}
# Shabbat stays out of view for people who did not ask for Jewish sources.
EREV_SOURCES = {'tanakh', 'sages'}

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
    meta[qid] = (source, tags, len(parts) > 3 and parts[3] == '!')

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

langs = sorted(f[:-4] for f in os.listdir(HERE) if f.endswith('.txt') and f != 'meta.txt')
en_shared, _ = parse('en')
out = ['// Generated by tool/quotes/build.py from tool/quotes/*.txt. Do not edit by hand.',
       '// ignore_for_file: lines_longer_than_80_chars', '',
       "import '../domain/quote.dart';", '',
       '/// Quotes shown in every language in their original words.',
       'const sharedQuotes = <Quote>[']
for qid, (source, tags, everywhere) in meta.items():
    if everywhere:
        text, by = en_shared[qid]
        out.append(f'  Quote({dart(text)}, {dart(by)}, QuoteSource.{source}, {dart(tags)}),')
out += ['];', '', '/// Quotes per language: translations of the shared set plus local ones.',
        'const quoteBank = <String, List<Quote>>{']
counts = {}
for lang in langs:
    shared, local = parse(lang)
    seen = set()
    out.append(f"  '{lang}': [")
    for qid, (source, tags, everywhere) in meta.items():
        if everywhere or qid not in shared:
            continue
        text, by = shared[qid]
        seen.add(text)
        out.append(f'    Quote({dart(text)}, {dart(by)}, QuoteSource.{source}, {dart(tags)}),')
    for text, by, source, tags in local:
        if text in seen:
            continue
        seen.add(text)
        out.append(f'    Quote({dart(text)}, {dart(by)}, QuoteSource.{source}, {dart(tags)}),')
    out.append('  ],')
    counts[lang] = len(seen)
out.append('};')
if problems:
    print('\n'.join(problems))
    sys.exit(f'{len(problems)} quotes broke the guard rails; nothing was written.')
open(OUT, 'w', encoding='utf-8').write('\n'.join(out) + '\n')
nshared = sum(1 for v in meta.values() if v[2])
print(f'{nshared} shared in original words;', ', '.join(f'{k} {v}' for k, v in counts.items()))
