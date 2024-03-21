import 'package:hive/hive.dart';
import 'package:mova/features/study/domain/usecase/service.dart';

part 'dto.g.dart';

@HiveType(typeId: 0)
class TaskDTO extends HiveObject {
  @HiveField(0)
  late int id;

  @HiveField(1)
  late int lessonId;

  @HiveField(2)
  late String name;

  @HiveField(3)
  late Map data;

  @HiveField(4)
  late bool isCompleted;

  @HiveField(5)
  late bool everCompleted;

  @HiveField(6)
  late String type;

  TaskDTO() {
    id = -1;
    lessonId = -1;
    name = "";
    data = {};
    isCompleted = false;
    everCompleted = false;
    type = "";
  }

  TaskDTO.fromTranslateWordTask(TranslateWordTask task) {
    id = task.id!;
    lessonId = task.lessonId!;
    name = task.name;
    data = {
      "word": task.word,
      "translations": task.translations,
      "rightIndex": task.rightIndex,
    };
    isCompleted = task.isCompleted;
    everCompleted = task.everCompleted;
    type = "TranslateWordTask";
  }

  TaskDTO.fromTranslateTextTask(TranslateTextTask task) {
    id = task.id!;
    lessonId = task.lessonId!;
    name = task.name;
    data = {
      "text": task.text,
      "rightTranslation": task.rightTranslation,
    };
    isCompleted = task.isCompleted;
    everCompleted = task.everCompleted;
    type = "TranslateTextTask";
  }

  TaskDTO.fromInsertWordsTask(InsertWordsTask task) {
    id = task.id!;
    lessonId = task.lessonId!;
    name = task.name;
    data = {
      "text": task.originText,
      "wordIndexes": task.wordIndexes,
    };
    isCompleted = task.isCompleted;
    everCompleted = task.everCompleted;
    type = "InsertWordsTask";
  }

  TaskDTO.fromWriteTranslationTask(WriteTranslationTask task) {
    id = task.id!;
    lessonId = task.lessonId!;
    name = task.name;
    data = {
      "text": task.text,
      "translation": task.translation,
    };
    isCompleted = task.isCompleted;
    everCompleted = task.everCompleted;
    type = "WriteTranslationTask";
  }

  TranslateWordTask toTranslateWordTask() {
    return TranslateWordTask(name, data["word"], data["translations"],
        data["rightIndex"], id, lessonId, everCompleted, isCompleted);
  }

  TranslateTextTask toTranslateTextTask() {
    return TranslateTextTask(name, data["text"], data["rightTranslation"], id,
        lessonId, everCompleted, isCompleted);
  }

  InsertWordsTask toInsertWordsTask() {
    return InsertWordsTask(
        name,
        data["text"],
        (data["wordIndexes"] as List<int>).toSet(),
        id,
        lessonId,
        everCompleted,
        isCompleted);
  }

  WriteTranslationTask toWriteTranslationTask() {
    return WriteTranslationTask(name, data["text"], data["translation"], id,
        lessonId, everCompleted, isCompleted);
  }
}

@HiveType(typeId: 1)
class LessonDTO extends HiveObject {
  @HiveField(0)
  late int id;

  @HiveField(1)
  late int moduleId;

  @HiveField(2)
  late String name;

  @HiveField(3)
  late int count;

  @HiveField(4)
  late int elementsCompleted;

  @HiveField(5)
  late bool isCompleted;

  @HiveField(6)
  late bool everCompleted;

  LessonDTO() {
    id = -1;
    moduleId = -1;
    name = "";
    count = -1;
    elementsCompleted = -1;
    isCompleted = false;
    everCompleted = false;
  }

  LessonDTO.fromLesson(Lesson lesson) {
    id = lesson.id!;
    moduleId = lesson.moduleId!;
    name = lesson.name;
    count = lesson.elementsCount;
    elementsCompleted = lesson.elementsCompleted;
    isCompleted = lesson.isCompleted;
    everCompleted = lesson.everCompleted;
  }

  Lesson toLesson() {
    return Lesson(name, count, id, moduleId, everCompleted, isCompleted,
        elementsCompleted);
  }
}

@HiveType(typeId: 2)
class ModuleDTO extends HiveObject {
  @HiveField(0)
  late int id;

  @HiveField(1)
  late String name;

  @HiveField(2)
  late int count;

  @HiveField(3)
  late int elementsCompleted;

  @HiveField(4)
  late bool isCompleted;

  @HiveField(5)
  late bool everCompleted;

  ModuleDTO() {
    id = -1;
    name = "";
    count = -1;
    elementsCompleted = -1;
    isCompleted = false;
    everCompleted = false;
  }

  ModuleDTO.fromModule(Module module) {
    id = module.id!;
    name = module.name;
    count = module.elementsCount;
    elementsCompleted = module.elementsCompleted;
    isCompleted = module.isCompleted;
    everCompleted = module.everCompleted;
  }

  Module toModule() {
    return Module(
        name, count, id, everCompleted, isCompleted, elementsCompleted);
  }
}
