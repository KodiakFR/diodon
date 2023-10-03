import 'package:diodon/entities/dive_group.dart';
import 'package:isar/isar.dart';

part 'dive.g.dart';

@collection
class Dive{
  Id id = Isar.autoIncrement;
  late String title;
  late String divingSite;
  late DateTime date; 
  late DateTime hourDepart;
  late String dp;
  late String boat;
  late String captain;
  late int nbPeople;
  late int nbDiver;
  final divreGroups = IsarLinks<DiveGroup>();
}