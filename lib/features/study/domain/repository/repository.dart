import 'package:hive_flutter/adapters.dart';
import 'package:mova/features/service.dart';
import 'package:mova/features/study/domain/repository/dto.dart';
import 'package:mova/features/study/domain/usecase/service.dart';
import 'package:mova/features/study/screens/insert_words_task_screen.dart';
import 'package:mova/features/study/screens/translate_text_task_screen.dart';
import 'package:mova/features/study/screens/translate_word_task_screen.dart';

class StudyRepository {
  Box<ModuleDTO>? modules;
  Box<LessonDTO>? lessons;
  Box<TaskDTO>? tasks;

  Future<StudyRepository> init() async {
    tasks = await Hive.openBox<TaskDTO>("tasks");
    lessons = await Hive.openBox<LessonDTO>("lessons");
    modules = await Hive.openBox<ModuleDTO>("modules");
    if (tasks!.isEmpty) {
      await initTasks();
    }
    if (lessons!.isEmpty) {
      await initLessons();
    }
    if (modules!.isEmpty) {
      await initModules();
    }
    return this;
  }

  Future clear() async {
    await Hive.deleteBoxFromDisk("tasks");
    await Hive.deleteBoxFromDisk("lessons");
    await Hive.deleteBoxFromDisk("modules");

    await init();
  }

  List<TaskDTO> getTasks(int lessonId) {
    return tasks!.values
        .where((element) => (element).lessonId == lessonId)
        .cast<TaskDTO>()
        .toList();
  }

  List<LessonDTO> getLessons(int moduleId) {
    return lessons!.values
        .where((element) => (element).moduleId == moduleId)
        .cast<LessonDTO>()
        .toList();
  }

  List<ModuleDTO> getModules() {
    return modules!.values.cast<ModuleDTO>().toList();
  }

  void updateTask(TaskDTO task) {
    tasks!.put(task.id, task);
  }

  void updateLesson(LessonDTO lesson) {
    lessons!.put(lesson.id, lesson);
  }

  void updateModule(ModuleDTO module) {
    modules!.put(module.id, module);
  }

  int modulesCompleted() {
    return modules!.values
        .where((element) => element.everCompleted == true)
        .length;
  }

  bool _isModuleCompleted(int id, int count) {
    return lessons!.values
            .where((element) =>
                element.moduleId == id && element.everCompleted == true)
            .length ==
        count;
  }

  int _moduleElementsCompleted(int id) {
    return lessons!.values
        .where((element) =>
            element.moduleId == id && element.everCompleted == true)
        .length;
  }

  Future initModules() async {
    await modules!.put(
        0,
        ModuleDTO.fromModule(Module("Жывёлы", 3, 0, _isModuleCompleted(0, 3),
            _isModuleCompleted(0, 3), _moduleElementsCompleted(0))));
    await modules!.put(
        1,
        ModuleDTO.fromModule(Module("Стравы", 1, 1, _isModuleCompleted(1, 1),
            _isModuleCompleted(1, 1), _moduleElementsCompleted(1))));
  }

  bool _isLessonCompleted(int id, int count) {
    return tasks!.values
            .where((element) =>
                element.lessonId == id && element.everCompleted == true)
            .length ==
        count;
  }

  int _lessonElementsCompleted(int id) {
    return tasks!.values
        .where((element) =>
            element.lessonId == id && element.everCompleted == true)
        .length;
  }

  Future initLessons() async {
    await lessons!.put(
        0,
        LessonDTO.fromLesson(Lesson(
            "занятак 1",
            2,
            0,
            0,
            _isLessonCompleted(0, 2),
            _isLessonCompleted(0, 2),
            _lessonElementsCompleted(0))));
    await lessons!.put(
        1,
        LessonDTO.fromLesson(Lesson(
            "занятак 2",
            9,
            1,
            0,
            _isLessonCompleted(1, 9),
            _isLessonCompleted(1, 9),
            _lessonElementsCompleted(1))));
    await lessons!.put(
        2,
        LessonDTO.fromLesson(Lesson(
            "занятак 3",
            5,
            2,
            0,
            _isLessonCompleted(2, 5),
            _isLessonCompleted(2, 5),
            _lessonElementsCompleted(2))));

    await lessons!.put(
        3,
        LessonDTO.fromLesson(Lesson(
            "занятак 1",
            4,
            3,
            1,
            _isLessonCompleted(3, 4),
            _isLessonCompleted(3, 4),
            _lessonElementsCompleted(3))));
  }

  bool _isTaskCompleted(int id) {
    return Service.user.progress > id;
  }

  Future initTasks() async {
    await tasks!.put(
        0,
        TaskDTO.fromTranslateWordTask(TranslateWordTask(
            "1",
            "Хто такі трус?",
            ["кролик", "трус", "мышь", "заяц"],
            0,
            0,
            0,
            _isTaskCompleted(0),
            _isTaskCompleted(0))));
    await tasks!.put(
        1,
        TaskDTO.fromInsertWordsTask(InsertWordsTask(
            "2",
            "пухнастыя звяры, якія пераважна жывуць y лесе, на палях i ў сельскай мясцовасці",
            {1, 3, 6, 12},
            1,
            0,
            _isTaskCompleted(1),
            _isTaskCompleted(1))));

    await tasks!.put(
        2,
        TaskDTO.fromTranslateWordTask(TranslateWordTask(
            "1",
            "вавёрка",
            ["лиса", "белка", "выдра", "куница"],
            1,
            2,
            1,
            _isTaskCompleted(2),
            _isTaskCompleted(2))));
    await tasks!.put(
        3,
        TaskDTO.fromTranslateWordTask(TranslateWordTask(
            "2",
            "дзік",
            ["медведь", "зубр", "волк", "кабан"],
            3,
            3,
            1,
            _isTaskCompleted(3),
            _isTaskCompleted(3))));
    await tasks!.put(
        4,
        TaskDTO.fromTranslateWordTask(TranslateWordTask(
            "3",
            "бусел",
            ["аист", "цапля", "лебедь", "фламинго"],
            0,
            4,
            1,
            _isTaskCompleted(4),
            _isTaskCompleted(4))));
    await tasks!.put(
        5,
        TaskDTO.fromInsertWordsTask(InsertWordsTask(
            "4",
            "Там дзе сонечныя промні прасочваюцца праз густыя яліны, жыве невялічкі дзік",
            {2, 5, 9},
            5,
            1,
            _isTaskCompleted(5),
            _isTaskCompleted(5))));
    await tasks!.put(
        6,
        TaskDTO.fromWriteTranslationTask(WriteTranslationTask("5", "белка",
            "вавёрка", 6, 1, _isTaskCompleted(6), _isTaskCompleted(6))));
    await tasks!.put(
        7,
        TaskDTO.fromInsertWordsTask(InsertWordsTask(
            "6",
            "Буслы ў той год не данеслі вясну на крылах — згубілі недзе па дарозе.",
            {3, 5, 8, 11},
            7,
            1,
            _isTaskCompleted(7),
            _isTaskCompleted(7))));
    await tasks!.put(
        8,
        TaskDTO.fromWriteTranslationTask(WriteTranslationTask("7", "кабан",
            "дзік", 8, 1, _isTaskCompleted(8), _isTaskCompleted(8))));
    await tasks!.put(
        9,
        TaskDTO.fromTranslateTextTask(TranslateTextTask(
            "8",
            "Каля нашай хаты звілі гняздо буслы",
            "Возле нашего дома свили гнездо аисты",
            9,
            1,
            _isTaskCompleted(9),
            _isTaskCompleted(9))));
    await tasks!.put(
        10,
        TaskDTO.fromTranslateWordTask(TranslateWordTask(
            "9",
            "белка",
            ["ліса", "куніца", "выдра", "вавёрка"],
            3,
            10,
            1,
            _isTaskCompleted(10),
            _isTaskCompleted(10))));

    await tasks!.put(
        11,
        TaskDTO.fromTranslateWordTask(TranslateWordTask(
            "1",
            "птушка",
            ["пушка", "птица", "синица", "ложка"],
            1,
            11,
            2,
            _isTaskCompleted(11),
            _isTaskCompleted(11))));
    await tasks!.put(
        12,
        TaskDTO.fromTranslateWordTask(TranslateWordTask(
            "2",
            "певень",
            ["певец", "птица", "петух", "паук"],
            2,
            12,
            2,
            _isTaskCompleted(12),
            _isTaskCompleted(12))));
    await tasks!.put(
        13,
        TaskDTO.fromTranslateWordTask(TranslateWordTask(
            "3",
            "зязюля",
            ["дедуля", "стриж", "мышь", "кукушка"],
            3,
            13,
            2,
            _isTaskCompleted(13),
            _isTaskCompleted(13))));
    await tasks!.put(
        14,
        TaskDTO.fromInsertWordsTask(InsertWordsTask(
            "4",
            "певень, ганарліва ўзняўшы галаву, пакрочыў па сваім валоданні - падваор'і",
            {2, 4, 9},
            14,
            2,
            _isTaskCompleted(14),
            _isTaskCompleted(14))));
    await tasks!.put(
        15,
        TaskDTO.fromInsertWordsTask(InsertWordsTask(
            "5",
            "Зязюля добра знаёмая кожнаму беларусу па яе характэрным 'ку-ку', які ўвесь час чуваць у гаях",
            {1, 4, 7, 11},
            15,
            2,
            _isTaskCompleted(15),
            _isTaskCompleted(15))));

    await tasks!.put(
        16,
        TaskDTO.fromTranslateWordTask(TranslateWordTask(
            "1",
            "бульба",
            ["картошка", "свекла", "редис", "морковь"],
            0,
            16,
            3,
            _isTaskCompleted(16),
            _isTaskCompleted(16))));
    await tasks!.put(
        17,
        TaskDTO.fromTranslateWordTask(TranslateWordTask(
            "2",
            "цыбуля",
            ["чеснок", "укроп", "лук", "свекла"],
            2,
            17,
            3,
            _isTaskCompleted(17),
            _isTaskCompleted(17))));
    await tasks!.put(
        18,
        TaskDTO.fromInsertWordsTask(InsertWordsTask(
            "3",
            "дранікі - гэта бліны з бульбы, якія падаюцца з салам і смятанай",
            {0, 5, 11},
            18,
            3,
            _isTaskCompleted(18),
            _isTaskCompleted(18))));
    await tasks!.put(
        19,
        TaskDTO.fromInsertWordsTask(InsertWordsTask(
            "4",
            "бабкай называюць так сама запечаную страву з бульбы, мяса і грыбоў",
            {1, 4, 7},
            19,
            3,
            _isTaskCompleted(19),
            _isTaskCompleted(19))));
  }
}
