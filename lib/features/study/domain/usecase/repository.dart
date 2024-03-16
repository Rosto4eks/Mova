part of study;

class Repository {
  late final List<Module> modules = [];
  late final List<Lesson> lessons = [];
  late final List<Task> tasks = [];

  Repository() {
    modules.add(Module("Жывёлы", 3, 0, false));
    modules.add(Module("Стравы", 2, 1, false));

    lessons.add(Lesson("Хто жыве ў лесе?", 9, 0, 0, false));
    lessons.add(Lesson("lesson 2", 2, 1, 0, false));
    lessons.add(Lesson("lesson 3", 3, 2, 0, false));

    lessons.add(Lesson("lesson 1", 2, 3, 1, false));
    lessons.add(Lesson("lesson 2", 3, 4, 1, false));

    tasks.add(TranslateWordTask("task 1", "вавёрка",
        ["лиса", "белка", "выдра", "куница"], 1, 0, 0, false));
    tasks.add(TranslateWordTask("task 2", "дзік",
        ["медведь", "зубр", "волк", "кабан"], 3, 1, 0, false));
    tasks.add(TranslateWordTask("task 3", "пацук",
        ["крыса", "мышь", "хомяк", "шиншила"], 0, 2, 0, false));
    tasks.add(InsertWordsTask(
        "task 4",
        "Там дзе сонечныя промні прасочваюцца праз густыя яліны, жыве дзік",
        {2, 5, 9},
        3,
        0,
        false));
    tasks.add(WriteTranslationTask("task 5", "белка", "вавёрка", 4, 0, false));
    tasks.add(InsertWordsTask(
        "task 6",
        "Маленькі пацук, які зусім нядаўна з'явіўся на свет, ужо хутка поўзае",
        {1, 4, 7, 10},
        5,
        0,
        false));
    tasks.add(WriteTranslationTask("task 7", "кабан", "дзік", 6, 0, false));
    tasks.add(TranslateTextTask(
        "task 8",
        "Тры дня таму Алеся ўпершыню убачыла шэрага пацука",
        "три дня назад Алеся впервые увидела серую крысу",
        7,
        0,
        false));
    tasks.add(TranslateWordTask("task 9", "белка",
        ["ліса", "куніца", "выдра", "вавёрка"], 3, 8, 0, false));

    tasks.add(TranslateTextTask("task 1", "d", "d", 10, 1, false));
    tasks.add(TranslateTextTask("task 2", "e", "e", 11, 1, false));

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
  // TODO SAVE
  //
}
