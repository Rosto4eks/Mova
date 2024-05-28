library study;

import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mova/features/study/domain/repository/dto.dart';
import 'package:mova/features/study/domain/repository/repository.dart';
import 'package:mova/features/service.dart';
import 'package:mova/features/users/domain/service.dart';
import 'package:mova/presentation/components/colors.dart';
import 'package:overlay_support/overlay_support.dart';

part 'module.dart';
part 'lesson.dart';
part 'tasks.dart';
part 'entity.dart';
part 'events.dart';
part 'functions.dart';

extension on List<ModuleDTO> {
  List<Module> toModules() => map((e) => e.toModule()).toList();
}

extension on List<LessonDTO> {
  List<Lesson> toLessons() => map((e) => e.toLesson()).toList();
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

class StudyService extends Entity with EntityContainer<Module>, Service {
  late final StudyRepository _repository;
  late final UserRepository _userRepository;

  Function achievementListener = () {};

  List<Module> get avaiableModules => _elements;

  StudyService(this._repository, this._userRepository, super.name, int count,
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

  Future clear() async {
    await _repository.clear();
    _elements = _repository.getModules().toModules();

    for (var element in _elements) {
      if (element.everCompleted) _elementsCompleted++;
    }

    for (int i = 0; i < _elements.length; i++) {
      _elements[i].notifier.add(_notifierEvent);
      _elements[i].notifier.add(_elementHandler);
      _elements[i].listeners.add(_elementHandler);
    }

    _elementsCompleted = _repository.modulesCompleted();
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
    handleAchievement(event);
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
        _userRepository.saveUser(Service.user);
        _userRepository.localSaveUser(Service.user);
        var tempModule = _elements
            .firstWhere((element) => element.id == event.data["moduleId"]);
        var tempLesson = tempModule._elements
            .firstWhere((element) => element.id == event.data["lessonId"]);
        var task = tempLesson._elements
            .firstWhere((element) => element.id == event.data["id"]);

        if (!event.data["everCompleted"]) {
          Service.user.incrementProgress();
        }

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

  void handleAchievement(Event event) async {
    if (Service.user.id == -1) return;
    if (event.name == "Task" && event.eventType == "Completed") {
      if (event.data["id"] == 9) {
        if (!Service.user.achievements.contains(0)) {
          Service.user.achievements.add(0);
          showAchievement("10 заданняў выпаўнена!");
          _userRepository.localSaveUser(Service.user);
          _userRepository.saveUser(Service.user);
        }
      }
      if (event.data["id"] == 19) {
        if (!Service.user.achievements.contains(1)) {
          Service.user.achievements.add(1);
          showAchievement("20 заданняў выпаўнена!");
          _userRepository.localSaveUser(Service.user);
          _userRepository.saveUser(Service.user);
        }
      }
      if (event.data["id"] == 29) {
        if (!Service.user.achievements.contains(2)) {
          Service.user.achievements.add(2);
          showAchievement("30 заданняў выпаўнена!");
          _userRepository.localSaveUser(Service.user);
          _userRepository.saveUser(Service.user);
        }
      }
      if (event.data["id"] == 39) {
        if (!Service.user.achievements.contains(3)) {
          Service.user.achievements.add(3);
          showAchievement("40 заданняў выпаўнена!");
          _userRepository.localSaveUser(Service.user);
          _userRepository.saveUser(Service.user);
        }
      }
      if (event.data["id"] == 49) {
        if (!Service.user.achievements.contains(4)) {
          Service.user.achievements.add(4);
          showAchievement("50 заданняў выпаўнена!");
          _userRepository.localSaveUser(Service.user);
          _userRepository.saveUser(Service.user);
        }
      }
    }
  }

  void showAchievement(String text) {
    showOverlayNotification((context) {
      return Card(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: const TextStyle(fontSize: 18, color: black),
              ),
              const Icon(
                Icons.star_rounded,
                color: lightGreen,
              )
            ],
          ),
        ),
      );
    }, duration: const Duration(seconds: 2));
  }
}
