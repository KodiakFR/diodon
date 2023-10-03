import 'package:diodon/entities/participant.dart';
import 'package:isar/isar.dart';

part 'weekend.g.dart';

@collection
class Weekend{
  Id? id = Isar.autoIncrement;
  late String title;
  late int nbDive;
  final participants = IsarLinks<Participant>();
  late DateTime start;
  late DateTime end;

}

