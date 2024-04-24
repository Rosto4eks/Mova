part of "service.dart";

class User {
  late final int id;
  String _role = "User";
  late String _name;
  // ignore: prefer_final_fields
  late String _email;
  late String _password;
  int _gems = 0;
  int _progress = 0;
  final List<int> _achievements;
  final List<int> _books;

  String get name => _name;
  String get role => _role;
  String get email => _email;
  int get gems => _gems;
  int get progress => _progress;
  String get password => _password;
  List<int> get achievements => _achievements;
  List<int> get books => _books;

  User(this.id, this._role, this._name, this._email, this._password, this._gems,
      this._progress, this._achievements, this._books);

  static User get empty => User(-1, "", "", "", "", 0, 0, [], []);

  void incrementProgress() {
    _progress++;
  }

  void resetProgress() {
    _progress = 0;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": _name,
        "email": _email,
        "password": _password,
        "role": _role,
        "gems": _gems,
        "progress": _progress,
        "achievements": _achievements,
        "books": _books,
      };

  static User fromJson(Map<String, dynamic> data) {
    var u = User(
        data["id"] as int,
        data["role"] as String,
        data["name"] as String,
        data["email"] as String,
        data["password"] as String,
        data["gems"] as int,
        data["progress"] as int,
        List.from(data["achievements"]),
        List.from(data["books"]));
    return u;
  }
}
