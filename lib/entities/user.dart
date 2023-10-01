import 'package:isar/isar.dart';

part 'user.g.dart';

@collection
class User {
  Id id = Isar.autoIncrement;
  String? name;
  String? firstName;
  String? password;

  User({
    required this.id,
    this.firstName,
    this.name,
    this.password,
});

User.register({
  this.name,
  this.firstName,
  this.password,
});

  User.empty();
}
