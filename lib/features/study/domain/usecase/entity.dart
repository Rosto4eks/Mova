part of study;

abstract class Entity {
  late final String name;
  late final int? id;
  bool _everCompleted = false;
  bool _isCompleted = false;
  Notifier notifier = Notifier();

  bool get everCompleted => _everCompleted;
  bool get isCompleted => _isCompleted;

  Entity(this.name,
      [this.id, this._everCompleted = false, this._isCompleted = false]);
}

abstract mixin class EntityContainer<T extends Entity> {
  late List<T> _elements = [];
  final List<Function> listeners = [];
  int _elementsCompleted = 0;
  late final int _elementsCount;

  int get elementsCompleted => _elementsCompleted;
  int get elementsCount => _elementsCount;

  void addElements(List<T> elems) {
    if (_elements.length + elems.length > elementsCount) {
      throw Exception("out of range ");
    }
    for (int i = 0; i < elems.length; i++) {
      elems[i].notifier.addAll(listeners);
    }
    _elements.addAll(elems);
  }
}
