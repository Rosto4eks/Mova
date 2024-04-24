part of 'service.dart';

class Lesson extends Entity with EntityContainer<Task> {
  late final int? moduleId;

  Lesson(super.name, int count,
      [super.id,
      this.moduleId,
      super._everCompleted,
      super._isCompleted,
      int elementsCompleted = 0]) {
    _elementsCount = count;
    _elementsCompleted = elementsCompleted;
    listeners.add(_notifierEvent);
  }

  Task nextTask() {
    if (_elements.isEmpty) {
      notifier.notify(Event(
        "Lesson",
        "Init",
        {"id": id, "moduleId": moduleId},
      ));
    }
    if (isCompleted) {
      throw Exception("all tasks completed");
    }
    return _elements[elementsCompleted];
  }

  void resetTasks() {
    for (int i = 0; i < _elementsCount; i++) {
      _elements[i].reset();
    }
    _elementsCompleted = 0;
    _isCompleted = false;
  }

  void _notifierEvent(Event event) {
    if (event.name != "Task" || event.eventType != "Completed") return;
    _elementsCompleted++;
    event.data["moduleId"] = moduleId;
    notifier.notify(event);
    if (elementsCompleted == elementsCount) {
      _isCompleted = true;
      if (!everCompleted) {
        _everCompleted = true;
        notifier.notify(Event(
          "Lesson",
          "Completed",
          {"id": id, "moduleId": moduleId},
        ));
      }
    }
  }
}
