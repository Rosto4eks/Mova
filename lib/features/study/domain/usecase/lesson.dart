part of study;

class Lesson extends Entity with EntityContainer<Task> {
  late final int? moduleId;

  Lesson(super.name, int count,
      [super.id, this.moduleId, super._everCompleted]) {
    _elementsCount = count;
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

  void _notifierEvent(Event event) {
    if (event.name != "Task" || event.eventType != "Completed") return;
    _elementsCompleted++;
    if (elementsCompleted == elementsCount) {
      _isCompleted = true;
      if (_isCompleted && !everCompleted) {
        _everCompleted = true;
        notifier.notify(Event(
          "Lesson",
          "Completed",
          {"id": id},
        ));
      }
    }
  }
}
