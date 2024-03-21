library study;

import 'dart:developer';
import 'dart:math';

import 'package:mova/features/study/domain/repository/dto.dart';
import 'package:mova/features/study/domain/repository/repository.dart';

part 'module.dart';
part 'lesson.dart';
part 'tasks.dart';
part 'entity.dart';
part 'events.dart';
part '../repository/fake_repository.dart';
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

    for (var element in _elements) {
      if (element.everCompleted) _elementsCompleted++;
    }

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
        var tempModule = _elements
            .firstWhere((element) => element.id == event.data["moduleId"]);
        var tempLesson = tempModule._elements
            .firstWhere((element) => element.id == event.data["id"]);
        _repository.updateLesson(LessonDTO.fromLesson(tempLesson));

        _repository.updateModule(ModuleDTO.fromModule(tempModule));
      } else if (event.name == "Task") {
        var tempModule = _elements
            .firstWhere((element) => element.id == event.data["moduleId"]);
        var tempLesson = tempModule._elements
            .firstWhere((element) => element.id == event.data["lessonId"]);
        var task = tempLesson._elements
            .firstWhere((element) => element.id == event.data["id"]);

        TaskDTO taskdto = switch (event.data["type"]) {
          "WriteTranslationTask" =>
            TaskDTO.fromWriteTranslationTask(task as WriteTranslationTask),
          "TranslateTextTask" =>
            TaskDTO.fromTranslateTextTask(task as TranslateTextTask),
          "InsertWordsTask" =>
            TaskDTO.fromInsertWordsTask(task as InsertWordsTask),
          _ => TaskDTO.fromTranslateWordTask(task as TranslateWordTask),
        };

        _repository.updateLesson(LessonDTO.fromLesson(tempLesson));
        _repository.updateTask(taskdto);
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
