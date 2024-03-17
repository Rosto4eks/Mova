part of study;

abstract class Task extends Entity {
  late final int? lessonId;
  Task(super.name, [super.id, this.lessonId, super._everCompleted = false]);

  bool check();
  void reset();
  String showCorrect();
}

abstract interface class InsertionTask extends Task {
  InsertionTask(super.name, [super.id, super.lessonId, super._everCompleted]);

  void insertWord(String word);
  void removeLast();
}

class TranslateWordTask extends Task {
  late final String _word;
  late final List<String> _translations;
  late final int _rightIndex;
  int _selectedIndex = -1;

  String get word => _word;
  List<String> get translations => _translations;

  TranslateWordTask(
      super.name, this._word, this._translations, this._rightIndex,
      [super.id, super.lessonId, super._everCompleted]);

  void selectTranslation(int pos) {
    if (pos < 0 || pos > _translations.length) {
      throw Exception("index out of range");
    }
    _selectedIndex = pos;
  }

  @override
  bool check() {
    _isCompleted = _selectedIndex == _rightIndex;
    if (_isCompleted) {
      _everCompleted = true;
      notifier.notify(Event(
        "Task",
        "Completed",
        {"id": id},
      ));
    }
    return isCompleted;
  }

  @override
  void reset() {
    _selectedIndex = -1;
    _isCompleted = false;
  }

  @override
  String showCorrect() {
    return _translations[_rightIndex];
  }
}

class InsertWordsTask extends InsertionTask {
  final String _text;
  late List<String> _allWords;
  late final List<int> _wordIndexes;
  late List<String> _words;
  int _index = 0;

  String get text => _allWords.join(' ');
  List<String> get words => _words;

  InsertWordsTask(super.name, this._text, Set<int> wordIndexes,
      [super.id, super.lessonId, super._everCompleted]) {
    _wordIndexes = wordIndexes.toList();
    _allWords = _text.split(' ');
    _words = [];
    _wordIndexes.shuffle();
    for (var elem in _wordIndexes) {
      if (elem < 0 || elem >= _allWords.length) {
        throw Exception("out of text range");
      }

      _words.add(_allWords[elem]);
      _allWords[elem] = "_" * _allWords[elem].length;
    }
    _wordIndexes.sort();
  }

  @override
  void insertWord(String word) {
    if (!_words.contains(word)) {
      throw Exception("word not found");
    }
    _words.remove(word);
    _allWords[_wordIndexes[_index]] = word;
    _index++;
  }

  @override
  void removeLast() {
    if (_index == 0) {
      return;
    }
    _index--;
    var word = _allWords[_wordIndexes[_index]];
    _words.add(word);
    _allWords[_wordIndexes[_index]] = "_" * word.length;
  }

  @override
  bool check() {
    _isCompleted = _text == text;
    if (_isCompleted) {
      _everCompleted = true;
      notifier.notify(Event(
        "Task",
        "Completed",
        {"id": id},
      ));
    }
    return isCompleted;
  }

  @override
  void reset() {
    _allWords = _text.split(' ');
    _words = [];

    for (var elem in _wordIndexes) {
      _words.add(_allWords[elem]);
      _allWords[elem] = "_" * _allWords[elem].length;
    }
    _wordIndexes.sort();
    _index = 0;
    _isCompleted = false;
  }

  @override
  String showCorrect() {
    return _text;
  }
}

class TranslateTextTask extends InsertionTask {
  final String _text;
  final String _translation;
  late List<String> _insertedWords;
  late List<String> _words;

  String get text => _text;
  List<String> get words => _words;
  String get translation => _insertedWords.join(' ');

  TranslateTextTask(super.name, this._text, this._translation,
      [super.id, super.lessonId, super._everCompleted]) {
    _words = _translation.split(' ');
    _words.shuffle();
    _insertedWords = [];
  }

  @override
  void insertWord(String word) {
    if (!_words.contains(word)) {
      throw Exception("word not found");
    }
    _words.remove(word);
    _insertedWords.add(word);
  }

  @override
  void removeLast() {
    if (_insertedWords.isEmpty) return;
    var word = _insertedWords.last;
    _words.add(word);
    _insertedWords.removeLast();
  }

  @override
  bool check() {
    _isCompleted = _translation == translation;
    if (_isCompleted) {
      _everCompleted = true;
      notifier.notify(Event(
        "Task",
        "Completed",
        {"id": id},
      ));
    }
    return isCompleted;
  }

  @override
  void reset() {
    _words = _translation.split(' ');
    _words.shuffle();
    _insertedWords = [];
    _isCompleted = false;
  }

  @override
  String showCorrect() {
    return _translation;
  }
}

class WriteTranslationTask extends Task {
  final String _text;
  final String _translation;
  String input = "";

  String get text => _text;

  WriteTranslationTask(super.name, this._text, this._translation,
      [super.id, super.lessonId, super._everCompleted]);

  void setInput(String text) {
    input = text;
  }

  @override
  bool check() {
    _isCompleted = _translation.toLowerCase() == input.toLowerCase();
    if (_isCompleted) {
      _everCompleted = true;
      notifier.notify(Event(
        "Task",
        "Completed",
        {"id": id},
      ));
    }
    return isCompleted;
  }

  @override
  void reset() {
    input = "";
    _isCompleted = false;
  }

  @override
  String showCorrect() {
    return _translation;
  }
}
