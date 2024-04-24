import 'package:hive/hive.dart';
import 'package:mova/features/users/domain/service.dart';

part 'dto.g.dart';

@HiveType(typeId: 3)
class UserDTO extends HiveObject {
  @HiveField(0)
  late int id;

  @HiveField(1)
  late String name;

  @HiveField(2)
  late String email;

  @HiveField(3)
  late String role;

  @HiveField(4)
  late String password;

  @HiveField(5)
  late int gems;

  @HiveField(6)
  late List<int> achievements;

  @HiveField(7)
  late List<int> books;

  @HiveField(8)
  late int progress;

  UserDTO() {
    id = -1;
    name = "";
    email = "";
    role = "";
    password = "";
    gems = 0;
    achievements = [];
    books = [];
    progress = 0;
  }

  UserDTO.fromUser(User user) {
    id = user.id;
    name = user.name;
    email = user.email;
    role = user.role;
    password = user.password;
    gems = user.gems;
    achievements = user.achievements;
    books = user.books;
    progress = user.progress;
  }

  User toUser() {
    return User(
        id, role, name, email, password, gems, progress, achievements, books);
  }
}
