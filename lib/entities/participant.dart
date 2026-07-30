import 'package:diodon/entities/dive_group.dart';
import 'package:diodon/entities/weekend.dart';
import 'package:isar/isar.dart';

part 'participant.g.dart';

@collection
class Participant {
  Id id = Isar.autoIncrement;
  String? name;
  String? firstName;
  String? diveLevel;
  String? type;
  String? aptitude;
  bool? selected;
  int? sort;
  final weekends = IsarLinks<Weekend>();
  final diveGroups = IsarLinks<DiveGroup>();

// Dans participant.dart
  Participant copy() {
    return Participant()
      ..name = name
      ..firstName = firstName
      ..diveLevel = diveLevel
      ..type = type
      ..aptitude = aptitude
      ..selected = selected
      ..sort = sort;
  }
}
