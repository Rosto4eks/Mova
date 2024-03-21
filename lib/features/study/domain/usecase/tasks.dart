part of study;

abstract class Task extends Entity {
  late final int? lessonId;
  Task(super.name,
      [super.id,
      this.lessonId,
      super._everCompleted = false,
      super._isCompleted = false]);

  bool check();
  void reset();
  String showCorrect();
}

abstract class InsertionTask extends Task {
  InsertionTask(super.name,
      [super.id,
      super.lessonId,
      super._everCompleted,
      super._isCompleted = false]);

  void insertWord(String word);
  void removeLast();
}

class TranslateWordTask extends Task {
  late final String _word;
  late final List<String> translations;
  late final int rightIndex;
  int _selectedIndex = -1;

  String get word => _word;
  TranslateWordTask(super.name, this._word, this.translations, this.rightIndex,
      [super.id,
      super.lessonId,
      super._everCompleted,
      super._isCompleted = false]);

  void selectTranslation(int pos) {
    if (pos < 0 || pos > translations.length) {
      throw Exception("index out of range");
    }
    _selectedIndex = pos;
  }

  @override
  bool check() {
    _isCompleted = _selectedIndex == rightIndex;
    if (_isCompleted) {
      _everCompleted = true;
      notifier.notify(Event(
        "Task",
        "Completed",
        {"id": id, "lessonId": lessonId, "type": "TranslateWordTask"},
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
    return translations[rightIndex];
  }
}

class InsertWordsTask extends InsertionTask {
  final String _text;
  late List<String> _allWords;
  late final List<int> wordIndexes;
  late Map<String, bool> _words;
  int _index = 0;

  String get text => _allWords.join(' ');
  String get originText => _text;
  Map<String, bool> get words => _words;

  InsertWordsTask(super.name, this._text, Set<int> wordIndexs,
      [super.id,
      super.lessonId,
      super._everCompleted,
      super._isCompleted = false]) {
    wordIndexes = wordIndexs.toList();
    _allWords = _text.split(' ');
    _words = {};
    wordIndexes.shuffle();
    for (var elem in wordIndexes) {
      if (elem < 0 || elem >= _allWords.length) {
        throw Exception("out of text range");
      }

      _words[_allWords[elem]] = true;
      _allWords[elem] = "_" * _allWords[elem].length;
    }
    wordIndexes.sort();
  }

  @override
  void insertWord(String word) {
    if (!_words.keys.contains(word)) {
      throw Exception("word not found");
    }
    _words[word] = false;
    _allWords[wordIndexes[_index]] = word;
    _index++;
  }

  @override
  void removeLast() {
    if (_index == 0) {
      return;
    }
    _index--;
    var word = _allWords[wordIndexes[_index]];
    _words[word] = true;
    _allWords[wordIndexes[_index]] = "_" * word.length;
  }

  @override
  bool check() {
    _isCompleted = _text == text;
    if (_isCompleted) {
      _everCompleted = true;
      notifier.notify(Event(
        "Task",
        "Completed",
        {"id": id, "lessonId": lessonId, "type": "InsertWordsTask"},
      ));
    }
    return isCompleted;
  }

  @override
  void reset() {
    _allWords = _text.split(' ');

    for (var elem in wordIndexes) {
      _words[_allWords[elem]] = true;
      _allWords[elem] = "_" * _allWords[elem].length;
    }
    wordIndexes.sort();
    _index = 0;
    _isCompleted = false;
  }

  @override
  String showCorrect() {
    return _text;
  }
}

class TranslateTextTask extends InsertionTask {
  final String text;
  final String rightTranslation;
  late List<String> _insertedWords;
  late Map<String, bool> _words;

  Map<String, bool> get words => _words;
  String get translation => _insertedWords.join(' ');

  TranslateTextTask(super.name, this.text, this.rightTranslation,
      [super.id,
      super.lessonId,
      super._everCompleted,
      super._isCompleted = false]) {
    _insertedWords = [];
    _words = {};
    var tempwords = rightTranslation.split(' ');
    tempwords.shuffle();
    for (var word in tempwords) {
      _words[word] = true;
    }
  }

  @override
  void insertWord(String word) {
    if (!_words.keys.contains(word)) {
      throw Exception("word not found");
    }
    _words[word] = false;
    _insertedWords.add(word);
  }

  @override
  void removeLast() {
    if (_insertedWords.isEmpty) return;
    var word = _insertedWords.last;
    _words[word] = true;
    _insertedWords.removeLast();
  }

  @override
  bool check() {
    _isCompleted = rightTranslation == translation;
    if (_isCompleted) {
      _everCompleted = true;
      notifier.notify(Event(
        "Task",
        "Completed",
        {"id": id, "lessonId": lessonId, "type": "TranslateTextTask"},
      ));
    }
    return isCompleted;
  }

  @override
  void reset() {
    var tempwords = rightTranslation.split(' ');
    tempwords.shuffle();
    for (var word in tempwords) {
      _words[word] = true;
    }
    _insertedWords = [];
    _isCompleted = false;
  }

  @override
  String showCorrect() {
    return rightTranslation;
  }
}

class WriteTranslationTask extends Task {
  final String text;
  final String translation;
  String input = "";

  WriteTranslationTask(super.name, this.text, this.translation,
      [super.id,
      super.lessonId,
      super._everCompleted,
      super._isCompleted = false]);

  void setInput(String text) {
    input = text;
  }

  @override
  bool check() {
    _isCompleted = translation.toLowerCase() == input.toLowerCase();
    if (_isCompleted) {
      _everCompleted = true;
      notifier.notify(Event(
        "Task",
        "Completed",
        {"id": id, "lessonId": lessonId, "type": "WriteTranslationTask"},
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
    return translation;
  }
}
