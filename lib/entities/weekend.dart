import 'package:diodon/entities/participant.dart';
import 'package:isar/isar.dart';

import 'dive.dart';

part 'weekend.g.dart';

@collection
class Weekend {
  Id? id = Isar.autoIncrement;
  late String title;
  late int nbDive;
  @Backlink(to: "weekends")
  final participants = IsarLinks<Participant>();
  late DateTime start;
  late DateTime end;
  @Backlink(to: "weekend")
  final dives = IsarLinks<Dive>();
}