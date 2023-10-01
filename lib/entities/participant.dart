import 'package:isar/isar.dart';

part 'participant.g.dart';

@collection
class Participant{
  Id id = Isar.autoIncrement;
  String? name;
  String? firstName;
  String? diveLevel;
  String? type;
}