part of "../domain/service.dart";

class UserRepository {
  final db = FirebaseFirestore.instance;
  Box<UserDTO>? userBox;

  Future<UserRepository> init() async {
    userBox = await Hive.openBox<UserDTO>("user");
    if (userBox!.isEmpty) {
      userBox!.put("user", UserDTO.fromUser(User.empty));
    }
    return this;
  }

  User loadUser() {
    return userBox!.get("user")!.toUser();
  }

  Future<User?> getUserByName(String name) async {
    User? user;
    await db
        .collection("users")
        .where("name", isEqualTo: name)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        user = User.fromJson(value.docs[0].data());
      }
    });
    return user;
  }

  Future<User> getUserById(int id) async {
    User user = User.empty;
    await db
        .doc("$id")
        .get()
        .then((value) => user = User.fromJson(value.data()!));
    return user;
  }

  Future<User> getUserByEmail(String email) async {
    User user = User.empty;
    await db
        .collection("users")
        .where("email", isEqualTo: email)
        .limit(1)
        .get()
        .then((value) {
      if (value.docs.length == 1) {
        user = User.fromJson(value.docs[0].data());
      } else {
        user = User.empty;
      }
    });
    return user;
  }

  Future saveUser(User user) async {
    if (user.id == User.empty.id) return;
    db.collection("users").doc("${user.id}").set(user.toJson());
  }

  void localSaveUser(User user) {
    userBox!.put("user", UserDTO.fromUser(user));
  }

  Future<int> getNewId() async {
    var id = -1;
    await db
        .collection("users")
        .orderBy("id", descending: true)
        .limit(1)
        .get()
        .then((value) => id = value.docs[0].data()["id"]);
    return id + 1;
  }
}
