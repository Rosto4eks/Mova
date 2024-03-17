import 'package:flutter/material.dart';
import 'package:mova/features/study/domain/usecase/study.dart';

class StudyProvider extends ChangeNotifier {
  final StudyService _service;
  late Module _selectedModule;
  late Lesson _selectedLesson;
  late bool _everFinished;

  StudyProvider(this._service);

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
    if (_selectedLesson.isCompleted) throw Exception("aboba");
    return _selectedLesson.nextTask();
  }

  bool isLessonEverFinished() => _everFinished;

  Lesson lastUncompletedLesson() => _service
          .avaiableModules[_service.elementsCompleted].avaiableLessons[
      _service.avaiableModules[_service.elementsCompleted].elementsCompleted];

  int setLastUncompletedLesson() {
    _selectedModule = _service.avaiableModules[_service.elementsCompleted];
    _selectedLesson =
        _selectedModule.avaiableLessons[_selectedModule.elementsCompleted];
    _everFinished = _selectedLesson.everCompleted;
    return _selectedModule.elementsCompleted;
  }

  void refresh() {
    notifyListeners();
  }
}
