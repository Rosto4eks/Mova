part of study;

class Module extends Entity with EntityContainer<Lesson> {
  List<Lesson> get avaiableLessons {
    if (_elements.isEmpty) {
      notifier.notify(Event(
        "Module",
        "Init",
        {"id": id},
      ));
    }
    return _elements;
  }

  Module(super.name, int count, [super.id, super.everCompleted]) {
    _elementsCount = count;
    listeners.add(_notifierEvent);
  }

  void _notifierEvent(Event event) {
    if (event.name != "Lesson" || event.eventType != "Completed") return;
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
}
