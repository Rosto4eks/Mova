import 'package:flutter/material.dart';
import 'package:mova/features/study/domain/usecase/service.dart';

class StudyProvider extends ChangeNotifier {
  final StudyService _service;
  late Module _selectedModule;
  late Lesson _selectedLesson;
  late bool _everFinished;

  StudyProvider(this._service) {
    if (_service.elementsCompleted == _service.elementsCount) {
      _selectedModule =
          _service.avaiableModules[_service.elementsCompleted - 1];
    } else {
      _selectedModule = _service.avaiableModules[_service.elementsCompleted];
    }
    if (_selectedModule.elementsCompleted == _selectedModule.elementsCount) {
      _selectedLesson = _selectedModule
          .avaiableLessons[_selectedModule.elementsCompleted - 1];
    } else {
      _selectedLesson =
          _selectedModule.avaiableLessons[_selectedModule.elementsCompleted];
    }
    _everFinished = _selectedLesson.everCompleted;
  }

  void clear() async {
    await _service.clear();
    notifyListeners();
  }

  int getModulesCount() {
    return _service.elementsCount;
  }

  bool isModuleEnabled(int index) {
    return index <= _service.elementsCompleted;
  }

  Module getModule(int index) => _service.avaiableModules[index];

  void selectModule(int index) {
    _selectedModule = _service.avaiableModules[index];
  }

  bool isLessonEnabled(int index) {
    return index <= _selectedModule.elementsCompleted;
  }

  Lesson getLesson(int index) => _selectedModule.avaiableLessons[index];

  void selectLesson(int index) {
    _selectedLesson = _selectedModule.avaiableLessons[index];
    _everFinished = _selectedLesson.everCompleted;
  }

  void resetTasks() {
    _selectedLesson.resetTasks();
    _everFinished = _selectedLesson.everCompleted;
  }

  Task getTask() {
    if (_selectedLesson.isCompleted) throw Exception("all tasks completed");
    return _selectedLesson.nextTask();
  }

  bool isLessonEverFinished() => _everFinished;

  Lesson lastUncompletedLesson() {
    if (_service.elementsCompleted == _service.elementsCount) {
      throw Exception("all modules completed");
    }
    return _service.avaiableModules[_service.elementsCompleted].avaiableLessons[
        _service.avaiableModules[_service.elementsCompleted].elementsCompleted];
  }

  int setLastUncompletedLesson() {
    _selectedModule = _service.avaiableModules[_service.elementsCompleted];
    _selectedLesson =
        _selectedModule.avaiableLessons[_selectedModule.elementsCompleted];
    _everFinished = _selectedLesson.everCompleted;
    return _selectedModule.elementsCompleted;
  }

  int getCurrentModule() {
    if (_service.elementsCompleted == _service.elementsCount) {
      return _service.elementsCount - 1;
    }
    return _service.avaiableModules.indexOf(_selectedModule);
  }

  int getCurrentLesson() {
    if (_selectedModule.elementsCompleted == _selectedModule.elementsCount) {
      return _selectedModule.elementsCount - 1;
    }
    return _selectedModule.avaiableLessons.indexOf(_selectedLesson);
  }

  void refresh() {
    notifyListeners();
  }
}
