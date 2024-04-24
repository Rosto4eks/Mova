part of '../usecase/service.dart';

class FakeRepository {
  late final List<Module> modules = [];
  late final List<Lesson> lessons = [];
  late final List<Task> tasks = [];

  FakeRepository() {
    modules.add(Module("Жывёлы", 3, 0, false));
    modules.add(Module("Стравы", 2, 1, false));

    lessons.add(Lesson("хто такі трус?", 2, 0, 0, false));
    lessons.add(Lesson("жывёлы радзімы", 9, 1, 0, false));
    lessons.add(Lesson("lesson 3", 3, 2, 0, false));

    lessons.add(Lesson("lesson 1", 2, 3, 1, false));
    lessons.add(Lesson("lesson 2", 3, 4, 1, false));

    tasks.add(TranslateWordTask("task 1", "Хто такі трус?",
        ["кролик", "трус", "мышь", "заяц"], 0, 0, 0, false));
    tasks.add(InsertWordsTask(
        "task 2",
        "пухнастыя звяры, якія пераважна жывуць y лесе, на палях i ў сельскай мясцовасці",
        {1, 3, 6, 12},
        1,
        0,
        false));

    tasks.add(TranslateWordTask("task 1", "вавёрка",
        ["лиса", "белка", "выдра", "куница"], 1, 2, 1, false));
    tasks.add(TranslateWordTask("task 2", "дзік",
        ["медведь", "зубр", "волк", "кабан"], 3, 3, 1, false));
    tasks.add(TranslateWordTask("task 3", "бусел",
        ["аист", "цапля", "лебедь", "фламинго"], 0, 4, 1, false));
    tasks.add(InsertWordsTask(
        "task 4",
        "Там дзе сонечныя промні прасочваюцца праз густыя яліны, жыве невялічкі дзік",
        {2, 5, 9},
        5,
        1,
        false));
    tasks.add(WriteTranslationTask("task 5", "белка", "вавёрка", 6, 1, false));
    tasks.add(InsertWordsTask(
        "task 6",
        "Буслы ў той год не данеслі вясну на крылах — згубілі недзе па дарозе.",
        {3, 5, 8, 11},
        7,
        1,
        false));
    tasks.add(WriteTranslationTask("task 7", "кабан", "дзік", 8, 1, false));
    tasks.add(TranslateTextTask("task 8", "Каля нашай хаты звілі гняздо буслы",
        "Возле нашего дома свили гнездо аисты", 9, 1, false));
    tasks.add(TranslateWordTask("task 9", "белка",
        ["ліса", "куніца", "выдра", "вавёрка"], 3, 10, 1, false));

    tasks.add(TranslateTextTask("task 1", "f", "f", 12, 2, false));
    tasks.add(TranslateTextTask("task 2", "g", "g", 13, 2, false));
    tasks.add(TranslateTextTask("task 3", "h", "h", 14, 2, false));

    tasks.add(TranslateTextTask("task 1", "i", "i", 15, 3, false));
    tasks.add(TranslateTextTask("task 2", "j", "j", 16, 3, false));

    tasks.add(TranslateTextTask("task 1", "k", "k", 17, 4, false));
    tasks.add(TranslateTextTask("task 2", "l", "l", 18, 4, false));
    tasks.add(TranslateTextTask("task 3", "m", "m", 19, 4, false));
  }

  List<Module> getModules() => modules;
  List<Lesson> getLessons(int moduleId) =>
      lessons.where((element) => element.moduleId == moduleId).toList();
  List<Task> getTasks(int lessonId) =>
      tasks.where((element) => element.lessonId == lessonId).toList();
}
