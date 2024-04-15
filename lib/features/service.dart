import 'package:mova/features/study/domain/usecase/service.dart';
import 'package:mova/features/users/domain/service.dart';

abstract class Service {
  static User user = User.empty;
  static Notifier notifier = Notifier();
}
