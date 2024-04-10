part of "service.dart";

class UserRepository {
  final db = FirebaseFirestore.instance.collection("users");
  List<Achievement> achievements = [];

  Future<List<User>> getUsersByName(String name) async {
    List<User> users = [];
    await db.where("name", isEqualTo: name).get().then((value) {
      for (var user in value.docs) {
        users.add(User.fromJson(user.data()));
      }
    });
    return users;
  }

  Future<User> getUserById(int id) async {
    User user = User.empty();
    await db
        .doc("$id")
        .get()
        .then((value) => user = User.fromJson(value.data()!));
    return user;
  }

  Future<User> getUserByEmail(String email) async {
    User user = User.empty();
    await db.where("email", isEqualTo: email).limit(1).get().then((value) {
      if (value.docs.length == 1) {
        user = User.fromJson(value.docs[0].data());
      } else {
        user = User.empty();
      }
    });
    return user;
  }

  Future saveUser(User user) async {
    await db.doc("${user.id}").set(user.toJson());
  }

  List<Achievement> getAllAchievements() {
    return achievements;
  }

  List<Achievement> getUserAchievements(List<int> ids) {
    List<Achievement> arr = [];
    for (int id in ids) {
      arr.add(achievements.firstWhere((element) => element.id == id));
    }
    return arr;
  }

  Future<int> getNewId() async {
    var id = -1;
    await db
        .orderBy("id", descending: true)
        .limit(1)
        .get()
        .then((value) => id = value.docs[0].data()["id"]);
    return id + 1;
  }
}
