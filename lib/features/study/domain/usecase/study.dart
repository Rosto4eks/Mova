library study;

import 'dart:developer';
import 'dart:math';

import 'package:mova/features/study/domain/repository/dto.dart';
import 'package:mova/features/study/domain/repository/study.dart';

part 'module.dart';
part 'lesson.dart';
part 'tasks.dart';
part 'entity.dart';
part 'events.dart';
part 'repository.dart';
part 'functions.dart';

extension on List<ModuleDTO> {
  List<Module> toModules() => this.map((e) => e.toModule()).toList();
}

extension on List<LessonDTO> {
  List<Lesson> toLessons() => this.map((e) => e.toLesson()).toList();
}

extension on List<TaskDTO> {
  List<Task> toTasks() => map((e) {
        if (e.type == "InsertWordsTask") {
          return e.toInsertWordsTask();
        } else if (e.type == "TranslateTextTask") {
          return e.toTranslateTextTask();
        } else if (e.type == "TranslateWordTask") {
          return e.toTranslateWordTask();
        } else {
          return e.toWriteTranslationTask();
        }
      }).toList();
}

class StudyService extends Entity with EntityContainer<Module> {
  late final IRepository _repository;

  List<Module> get avaiableModules => _elements;

  StudyService(this._repository, super.name, int count,
      [super.id, super.everCompleted]) {
    _elements = _repository.getModules().toModules();
    _elements.forEach((element) {
      if (element._isCompleted) _elementsCompleted++;
    });
    for (int i = 0; i < _elements.length; i++) {
      _elements[i].notifier.add(_notifierEvent);
      _elements[i].notifier.add(_elementHandler);
      _elements[i].listeners.add(_elementHandler);
    }
    _elementsCount = count;
  }

  void _notifierEvent(Event event) {
    if (event.name != "Module" || event.eventType != "Completed") return;
    _elementsCompleted++;
    if (elementsCompleted == elementsCount) {
      _isCompleted = true;
      if (_isCompleted && !everCompleted) {
        _everCompleted = true;
        notifier.notify(Event(
          "Module",
          "Completed",
          {"id": id},
        ));
      }
    }
  }

  void _elementHandler(Event event) {
    if (event.eventType == "Completed") {
      if (event.name == "Module") {
        _repository.updateModule(ModuleDTO.fromModule(
            _elements.firstWhere((element) => element.id == event.data["id"])));
      } else if (event.name == "Lesson") {
        _repository.updateLesson(LessonDTO.fromLesson(_elements
            .firstWhere((element) => element.id == event.data["moduleId"])
            ._elements
            .firstWhere((element) => element.id == event.data["id"])));

        _repository.updateModule(ModuleDTO.fromModule(_elements
            .firstWhere((element) => element.id == event.data["moduleId"])));
      } else if (event.name == "Task") {
        _repository.updateLesson(LessonDTO.fromLesson(_elements
            .firstWhere((element) => element.id == event.data["moduleId"])
            ._elements
            .firstWhere((element) => element.id == event.data["lessonId"])));
        var task = _elements
            .firstWhere((element) => element.id == event.data["moduleId"])
            ._elements
            .firstWhere((element) => element.id == event.data["lessonId"])
            ._elements
            .firstWhere((element) => element.id == event.data["id"]);
        if (event.data["type"] == "WriteTranslationTask") {
          _repository.updateTask(
              TaskDTO.fromWriteTranslationTask(task as WriteTranslationTask));
        } else if (event.data["type"] == "TranslateTextTask") {
          _repository.updateTask(
              TaskDTO.fromTranslateTextTask(task as TranslateTextTask));
        } else if (event.data["type"] == "InsertWordsTask") {
          _repository
              .updateTask(TaskDTO.fromInsertWordsTask(task as InsertWordsTask));
        } else if (event.data["type"] == "TranslateWordTask") {
          _repository.updateTask(
              TaskDTO.fromTranslateWordTask(task as TranslateWordTask));
        }
      }
    }
    if (event.eventType != "Init") return;
    if (event.name == "Module") {
      _elements
          .firstWhere((element) => element.id == event.data["id"])
          .addElements(_repository.getLessons(event.data["id"]).toLessons());
    } else if (event.name == "Lesson") {
      _elements
          .firstWhere((element) => element.id == event.data["moduleId"])
          ._elements
          .firstWhere((element) => element.id == event.data["id"])
          .addElements(_repository.getTasks(event.data["id"]).toTasks());
    }
  }
}
