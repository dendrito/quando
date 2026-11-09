/// A search over event titles, with wildcards and AND / OR / NOT:
///
///   dentist                 title contains "dentist" (any case)
///   dent*  ?oga             * = any letters, ? = one letter, matched to a word
///   "team sync"             the exact phrase
///   gym yoga                both (AND is implied)
///   flight OR train         either; `|` works too
///   meeting -cancelled      NOT; `NOT` and `!` work too
///   (gym OR yoga) morning   brackets group
///
/// Empty matches everything. A query never fails: odd input is read as
/// plainly as possible.
class EventQuery {
  EventQuery._(this.source, this._root);

  final String source;
  final _Node? _root;

  static final _cache = <String, EventQuery>{};

  /// Parsed queries are kept, so matching thousands of events is cheap.
  factory EventQuery.parse(String query) => _cache[query] ??= EventQuery._(query, _Parser(_tokenize(query)).parse());

  bool get isEmpty => _root == null;

  bool matches(String title) => _root?.test(title.toLowerCase()) ?? true;

  /// The plain words and phrases in the query (not the NOT ones), to
  /// highlight in results.
  List<String> get terms => _root?.terms(positive: true) ?? const [];
}

// ---- Tokens ----

enum _T { term, phrase, and, or, not, open, close }

class _Tok {
  const _Tok(this.type, [this.text = '']);
  final _T type;
  final String text;
}

List<_Tok> _tokenize(String q) {
  final out = <_Tok>[];
  var i = 0;
  while (i < q.length) {
    final c = q[i];
    if (c.trim().isEmpty) {
      i++;
    } else if (c == '(') {
      out.add(const _Tok(_T.open));
      i++;
    } else if (c == ')') {
      out.add(const _Tok(_T.close));
      i++;
    } else if (c == '|') {
      out.add(const _Tok(_T.or));
      i++;
    } else if (c == '&') {
      out.add(const _Tok(_T.and));
      i++;
    } else if ((c == '-' || c == '!') && i + 1 < q.length && q[i + 1].trim().isNotEmpty) {
      out.add(const _Tok(_T.not));
      i++;
    } else if (c == '"' || c == '“' || c == '”') {
      final end = q.indexOf(RegExp('["“”]'), i + 1);
      final text = q.substring(i + 1, end < 0 ? q.length : end);
      if (text.trim().isNotEmpty) out.add(_Tok(_T.phrase, text.toLowerCase()));
      i = end < 0 ? q.length : end + 1;
    } else {
      var j = i;
      while (j < q.length && q[j].trim().isNotEmpty && !'()|&"“”'.contains(q[j])) {
        j++;
      }
      final word = q.substring(i, j);
      out.add(switch (word) {
        'OR' => const _Tok(_T.or),
        'AND' => const _Tok(_T.and),
        'NOT' => const _Tok(_T.not),
        _ => _Tok(_T.term, word.toLowerCase()),
      });
      i = j;
    }
  }
  return out;
}

// ---- Tree ----

abstract class _Node {
  bool test(String title);
  List<String> terms({required bool positive});
}

class _Match implements _Node {
  _Match(this.text, {required bool phrase})
    : _glob = text.contains(RegExp(r'[*?]')) ? _globToRegex(text, anchored: !phrase) : null;

  final String text;
  final RegExp? _glob;

  static final _words = RegExp(r'[\p{L}\p{N}]+', unicode: true);

  @override
  bool test(String title) {
    final g = _glob;
    if (g == null) return title.contains(text);
    if (g.hasMatch(title)) return true;
    return _words.allMatches(title).any((w) => g.hasMatch(w[0]!));
  }

  @override
  List<String> terms({required bool positive}) => positive ? [text] : const [];

  static RegExp _globToRegex(String glob, {required bool anchored}) {
    final b = StringBuffer(anchored ? '^' : '');
    for (final ch in glob.split('')) {
      b.write(switch (ch) {
        '*' => '.*',
        '?' => '.',
        _ => RegExp.escape(ch),
      });
    }
    if (anchored) b.write(r'$');
    return RegExp(b.toString(), unicode: true);
  }
}

class _Not implements _Node {
  _Not(this.inner);
  final _Node inner;

  @override
  bool test(String title) => !inner.test(title);

  @override
  List<String> terms({required bool positive}) => inner.terms(positive: !positive);
}

class _All implements _Node {
  _All(this.parts);
  final List<_Node> parts;

  @override
  bool test(String title) => parts.every((p) => p.test(title));

  @override
  List<String> terms({required bool positive}) => [for (final p in parts) ...p.terms(positive: positive)];
}

class _Any implements _Node {
  _Any(this.parts);
  final List<_Node> parts;

  @override
  bool test(String title) => parts.any((p) => p.test(title));

  @override
  List<String> terms({required bool positive}) => [for (final p in parts) ...p.terms(positive: positive)];
}

// ---- Parser ----

class _Parser {
  _Parser(this._toks);

  final List<_Tok> _toks;
  var _i = 0;

  _Tok? get _peek => _i < _toks.length ? _toks[_i] : null;

  _Node? parse() {
    final parts = <_Node>[];
    while (_peek != null) {
      final n = _or();
      if (n != null) parts.add(n);
      // A stray ")" or operator: skip it and carry on.
      if (_peek != null && n == null) _i++;
    }
    if (parts.isEmpty) return null;
    return parts.length == 1 ? parts.single : _All(parts);
  }

  _Node? _or() {
    final parts = <_Node>[?_and()];
    while (_peek?.type == _T.or) {
      _i++;
      final n = _and();
      if (n != null) parts.add(n);
    }
    if (parts.isEmpty) return null;
    return parts.length == 1 ? parts.single : _Any(parts);
  }

  _Node? _and() {
    final parts = <_Node>[];
    while (true) {
      final t = _peek;
      if (t == null || t.type == _T.or || t.type == _T.close) break;
      if (t.type == _T.and) {
        _i++;
        continue;
      }
      final n = _unary();
      if (n == null) break;
      parts.add(n);
    }
    if (parts.isEmpty) return null;
    return parts.length == 1 ? parts.single : _All(parts);
  }

  _Node? _unary() {
    final t = _peek;
    if (t == null) return null;
    if (t.type == _T.not) {
      _i++;
      final inner = _unary();
      return inner == null ? null : _Not(inner);
    }
    if (t.type == _T.open) {
      _i++;
      final inner = _or();
      if (_peek?.type == _T.close) _i++;
      return inner;
    }
    if (t.type == _T.term || t.type == _T.phrase) {
      _i++;
      return _Match(t.text, phrase: t.type == _T.phrase);
    }
    return null;
  }
}
