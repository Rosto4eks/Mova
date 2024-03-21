import 'package:hive_flutter/adapters.dart';
import 'package:mova/features/study/domain/repository/dto.dart';
import 'package:mova/features/study/domain/usecase/study.dart';

abstract interface class IRepository {
  List<ModuleDTO> getModules();
  List<LessonDTO> getLessons(int moduleId);
  List<TaskDTO> getTasks(int lessonId);

  void updateTask(TaskDTO task);

  void updateLesson(LessonDTO lesson);

  void updateModule(ModuleDTO module);
}

class StudyRepository implements IRepository {
  Box<ModuleDTO>? modules;
  Box<LessonDTO>? lessons;
  Box<TaskDTO>? tasks;

  Future<StudyRepository> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TaskDTOAdapter());
    Hive.registerAdapter(LessonDTOAdapter());
    Hive.registerAdapter(ModuleDTOAdapter());
    tasks = await Hive.openBox<TaskDTO>("tasks");
    lessons = await Hive.openBox<LessonDTO>("lessons");
    modules = await Hive.openBox<ModuleDTO>("modules");
    if (tasks!.isEmpty) {
      initTasks();
    }
    if (lessons!.isEmpty) {
      initLessons();
    }
    if (modules!.isEmpty) {
      initModules();
    }
    return this;
  }

  @override
  List<TaskDTO> getTasks(int lessonId) {
    return tasks!.values
        .where((element) => (element).lessonId == lessonId)
        .cast<TaskDTO>()
        .toList();
  }

  @override
  List<LessonDTO> getLessons(int moduleId) {
    return lessons!.values
        .where((element) => (element).moduleId == moduleId)
        .cast<LessonDTO>()
        .toList();
  }

  @override
  List<ModuleDTO> getModules() {
    return modules!.values.cast<ModuleDTO>().toList();
  }

  @override
  void updateTask(TaskDTO task) {
    tasks!.put(task.id, task);
  }

  @override
  void updateLesson(LessonDTO lesson) {
    lessons!.put(lesson.id, lesson);
  }

  @override
  void updateModule(ModuleDTO module) {
    modules!.put(module.id, module);
  }

  void initModules() {
    modules!.put(0, ModuleDTO.fromModule(Module("Жывёлы", 3, 0, false)));
    modules!.put(1, ModuleDTO.fromModule(Module("Стравы", 2, 1, false)));
  }

  void initLessons() {
    lessons!
        .put(0, LessonDTO.fromLesson(Lesson("хто такі трус?", 2, 0, 0, false)));
    lessons!
        .put(1, LessonDTO.fromLesson(Lesson("жывёлы радзімы", 9, 1, 0, false)));
    lessons!.put(2, LessonDTO.fromLesson(Lesson("lesson 3", 3, 2, 0, false)));
    lessons!.put(3, LessonDTO.fromLesson(Lesson("lesson 1", 2, 3, 1, false)));
    lessons!.put(4, LessonDTO.fromLesson(Lesson("lesson 2", 3, 4, 1, false)));
  }

  void initTasks() {
    tasks!.put(
        0,
        TaskDTO.fromTranslateWordTask(TranslateWordTask(
            "task 1",
            "Хто такі трус?",
            ["кролик", "трус", "мышь", "заяц"],
            0,
            0,
            0,
            false)));
    tasks!.put(
        1,
        TaskDTO.fromInsertWordsTask(InsertWordsTask(
            "task 2",
            "пухнастыя звяры, якія пераважна жывуць y лесе, на палях i ў сельскай мясцовасці",
            {1, 3, 6, 12},
            1,
            0,
            false)));

    tasks!.put(
        2,
        TaskDTO.fromTranslateWordTask(TranslateWordTask("task 1", "вавёрка",
            ["лиса", "белка", "выдра", "куница"], 1, 2, 1, false)));
    tasks!.put(
        3,
        TaskDTO.fromTranslateWordTask(TranslateWordTask("task 2", "дзік",
            ["медведь", "зубр", "волк", "кабан"], 3, 3, 1, false)));
    tasks!.put(
        4,
        TaskDTO.fromTranslateWordTask(TranslateWordTask("task 3", "бусел",
            ["аист", "цапля", "лебедь", "фламинго"], 0, 4, 1, false)));
    tasks!.put(
        5,
        TaskDTO.fromInsertWordsTask(InsertWordsTask(
            "task 4",
            "Там дзе сонечныя промні прасочваюцца праз густыя яліны, жыве невялічкі дзік",
            {2, 5, 9},
            5,
            1,
            false)));
    tasks!.put(
        6,
        TaskDTO.fromWriteTranslationTask(
            WriteTranslationTask("task 5", "белка", "вавёрка", 6, 1, false)));
    tasks!.put(
        7,
        TaskDTO.fromInsertWordsTask(InsertWordsTask(
            "task 6",
            "Буслы ў той год не данеслі вясну на крылах — згубілі недзе па дарозе.",
            {3, 5, 8, 11},
            7,
            1,
            false)));
    tasks!.put(
        8,
        TaskDTO.fromWriteTranslationTask(
            WriteTranslationTask("task 7", "кабан", "дзік", 8, 1, false)));
    tasks!.put(
        9,
        TaskDTO.fromTranslateTextTask(TranslateTextTask(
            "task 8",
            "Каля нашай хаты звілі гняздо буслы",
            "Возле нашего дома свили гнездо аисты",
            9,
            1,
            false)));
    tasks!.put(
        10,
        TaskDTO.fromTranslateWordTask(TranslateWordTask("task 9", "белка",
            ["ліса", "куніца", "выдра", "вавёрка"], 3, 10, 1, false)));

    tasks!.put(
        11,
        TaskDTO.fromTranslateTextTask(
            TranslateTextTask("task 1", "f", "f", 11, 2, false)));
    tasks!.put(
        12,
        TaskDTO.fromTranslateTextTask(
            TranslateTextTask("task 2", "g", "g", 12, 2, false)));
    tasks!.put(
        13,
        TaskDTO.fromTranslateTextTask(
            TranslateTextTask("task 3", "h", "h", 13, 2, false)));

    tasks!.put(
        14,
        TaskDTO.fromTranslateTextTask(
            TranslateTextTask("task 1", "i", "i", 14, 3, false)));
    tasks!.put(
        15,
        TaskDTO.fromTranslateTextTask(
            TranslateTextTask("task 2", "j", "j", 15, 3, false)));

    tasks!.put(
        16,
        TaskDTO.fromTranslateTextTask(
            TranslateTextTask("task 1", "k", "k", 16, 4, false)));
    tasks!.put(
        17,
        TaskDTO.fromTranslateTextTask(
            TranslateTextTask("task 2", "l", "l", 17, 4, false)));
    tasks!.put(
        18,
        TaskDTO.fromTranslateTextTask(
            TranslateTextTask("task 3", "m", "m", 18, 4, false)));
  }
}
