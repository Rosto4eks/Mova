part of "service.dart";

class User {
  late final int id;
  String _role = "User";
  late String _name;
  late String _email;
  late String _password;
  int _gems = 0;
  final List<int> _achievements;
  final List<int> _books;

  String get name => _name;
  String get role => _role;
  String get email => _email;
  int get gems => _gems;

  User(this.id, this._role, this._name, this._email, this._password, this._gems,
      this._achievements, this._books);

  User.empty() : this(-1, "User", "User", "", "", 0, [], []);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": _name,
        "email": _email,
        "password": _password,
        "role": _role,
        "gems": _gems,
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
        List.from(data["achievements"]),
        List.from(data["books"]));
    return u;
  }
}
