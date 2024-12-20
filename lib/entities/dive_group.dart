import 'package:diodon/entities/participant.dart';
import 'package:isar/isar.dart';

import 'dive.dart';

part 'dive_group.g.dart';

@collection
class DiveGroup{
  Id id = Isar.autoIncrement;
  late String? title;
  late bool? standAlone;
  late bool? supervised;
  late String? dpDeep;
  late String? dpTime;
  late String? realDeep;
  late String? realTime;
  late String? divingStop;
  @Backlink(to: "diveGroups")
  final participants = IsarLinks<Participant>();
  final dive = IsarLink<Dive>();
}