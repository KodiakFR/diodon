import 'package:diodon/entities/participant.dart';
import 'package:isar/isar.dart';

part 'dive_group.g.dart';

@collection
class DiveGroup{
  Id id = Isar.autoIncrement;
  late String title;
  final participants = IsarLinks<Participant>();
}