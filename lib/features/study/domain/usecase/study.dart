library study;

import 'dart:developer';
import 'dart:math';

import 'package:flutter/cupertino.dart';

part 'module.dart';
part 'lesson.dart';
part 'tasks.dart';
part 'entity.dart';
part 'events.dart';
part 'repository.dart';
part 'functions.dart';

class StudyService extends Entity with EntityContainer<Module> {
  late final Repository _repository;

  List<Module> get avaiableModules => _elements;

  StudyService(this._repository, super.name, int count,
      [super.id, super.everCompleted]) {
    _elements = _repository.getModules();
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
    print(event);
    if (event.eventType != "Init") return;
    if (event.name == "Module") {
      _elements
          .firstWhere((element) => element.id == event.data["id"])
          .addElements(_repository.getLessons(event.data["id"]));
    }
    if (event.name == "Lesson") {
      _elements
          .firstWhere((element) => element.id == event.data["moduleId"])
          ._elements
          .firstWhere((element) => element.id == event.data["id"])
          .addElements(_repository.getTasks(event.data["id"]));
    }
  }
}
