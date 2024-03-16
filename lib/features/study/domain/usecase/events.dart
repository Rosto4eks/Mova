part of study;

class Event {
  final String name;
  final String eventType;
  Map<String, dynamic> data;
  Event(this.name, this.eventType, [this.data = const {}]);

  @override
  String toString() => "$name with id: $data, event: $eventType";
}

class Notifier {
  final List<Function> _listeners = [];

  void add(Function func) {
    _listeners.add(func);
  }

  void addAll(List<Function> funcs) {
    _listeners.addAll(funcs);
  }

  void notify(Event event) {
    for (var listener in _listeners) {
      listener(event);
    }
  }
}
