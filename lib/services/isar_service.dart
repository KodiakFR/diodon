import 'package:diodon/entities/dive.dart';
import 'package:diodon/entities/dive_group.dart';
import 'package:diodon/entities/participant.dart';
import 'package:diodon/entities/user.dart';
import 'package:diodon/entities/weekend.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = openDB();
  }

  //Création de la base de données
  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      return await Isar.open(
        [
          UserSchema,
          DiveSchema,
          DiveGroupSchema,
          ParticipantSchema,
          WeekendSchema
        ],
        inspector: true,
        directory: dir.path,
      );
    }
    return Future.value(Isar.getInstance());
  }

  //-----------------------------------------------------------------------------------------------------------------------------------------------------------
  //--------------------------------------------------------------------- USER --------------------------------------------------------------------------------

  Future<bool> saveUser(User user) async {
    final isar = await db;
    final List<User> users = await isar.users
        .filter()
        .firstNameEqualTo(user.firstName)
        .nameEqualTo(user.name)
        .findAll();
    if (users.isEmpty) {
      isar.writeTxnSync<int>(() => isar.users.putSync(user));
      return true;
    } else {
      return false;
    }
  }

  Future<User> getUser(int id) async {
    final isar = await db;
    User? user = await isar.users.where().idEqualTo(id).findFirst();
    return user!;
  }

  Future<List<User>> getAllUsers() async {
    final isar = await db;
    return await isar.users.where().findAll();
  }

  Future<String> getPasswordUser(int id) async {
    final isar = await db;
    final List<User> users = await isar.users.filter().idEqualTo(id).findAll();
    if (users.length == 1) {
      return users[0].password!;
    } else {
      return '';
    }
  }

//-----------------------------------------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------- WEEKEND -----------------------------------------------------------------------------
  Future<List<Weekend>> getAllWeekend() async {
    final isar = await db;
    DateTime now = DateTime.now();
    DateTime onYearAgo = DateTime(now.year - 1, now.month, now.day);
    final List<Weekend> weekends =
        await isar.weekends.filter().endGreaterThan(onYearAgo).findAll();
    return weekends;
  }

  Future<bool> saveWeekend(Weekend weekend) async {
    final isar = await db;
    final List<Weekend> weekends =
        await isar.weekends.filter().titleEqualTo(weekend.title).findAll();
    if (weekends.isEmpty) {
      isar.writeTxnSync<int>(() => isar.weekends.putSync(weekend));
      return true;
    } else {
      return false;
    }
  }

  Future<Weekend?> getWeekendByTitle(String title) async {
    final isar = await db;
    final List<Weekend> weekends =
        await isar.weekends.filter().titleEqualTo(title).findAll();
    if (weekends.length == 1) {
      final Weekend weekend = weekends[0];
      return weekend;
    }
    return null;
  }

  Future<bool> deleteWeekend(Weekend weekend) async {
    final isar = await db;
    final success = isar.writeTxnSync(() => isar.weekends.deleteSync(weekend.id!));
    return success;
  }
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------- PARTICIPANTS-------------------------------------------------------------------------

  Future<List<Participant>> getParticipantsFromWeekend(Id weekendID) async {
    final isar = await db;
    return await isar.participants
        .filter()
        .weekends((q) => q.idEqualTo(weekendID))
        .findAll();
  }

  Future<bool> addParticipants(Weekend weekend, Participant participant) async {
    final isar = await db;
    final List<Participant> participants = await isar.participants
        .filter()
        .weekends((q) => q.idEqualTo(weekend.id))
        .firstNameEqualTo(participant.firstName)
        .nameEqualTo(participant.name)
        .findAll();
    if (participants.isEmpty) {
      isar.writeTxnSync<int>(() => isar.participants.putSync(participant));
      return true;
    } else {
      return false;
    }
  }

  Future<void> removeParticipantsInWeekend(
      Participant participant, Weekend weekend) async {
    final isar = await db;
    List<Participant> participants = await isar.participants
        .filter()
        .weekends((q) => q.idEqualTo(weekend.id))
        .idEqualTo(participant.id)
        .findAll();
    if (participants.length == 1) {
      await isar.writeTxn(() async {
        await isar.participants.delete(participants[0].id);
      });
    }
  }

  Future<void> upDateParticipant(Participant participant) async {
    final isar = await db;
    isar.writeTxnSync(() => isar.participants.putSync(participant));
  }

  Future<List<Participant>> getParticipantsSelected(Dive dive) async {
    final isar = await db;
    final List<Participant> particiapants = await isar.participants
        .filter()
        .weekends((w) => w.dives((d) => d.idEqualTo(dive.id)))
        .selectedEqualTo(true)
        .findAll();
    return particiapants;
  }

//-----------------------------------------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------- DIVES -------------------------------------------------------------------------------

  Future<List<Dive>> getAllDiveByWeekend(Weekend weekend) async {
    final isar = await db;
    return await isar.dives
        .filter()
        .weekend((q) => q.idEqualTo(weekend.id))
        .findAll();
  }

  Future<bool> saveDive(Weekend weekend, Dive dive) async {
    final isar = await db;
    final List<Dive> dives = await isar.dives
        .filter()
        .weekend((q) => q.idEqualTo(weekend.id))
        .titleEqualTo(dive.title)
        .findAll();
    if (dives.isEmpty) {
      isar.writeTxnSync<int>(() => isar.dives.putSync(dive));
      return true;
    } else {
      return false;
    }
  }

//-----------------------------------------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------- DIVES GROUP -------------------------------------------------------------------------

  Future<List<Participant>> getAllDiverForDive(Dive dive) async {
    final isar = await db;
    List<Participant> particiapants = await isar.participants
        .filter()
        .weekends((w) => w.dives((d) => d.idEqualTo(dive.id)))
        .typeEqualTo('Plongeur')
        .or()
        .typeEqualTo('Encadrant')
        .findAll();
    return particiapants;
  }

  Future<List<DiveGroup>> getAllDiveGroupForDive(Dive dive) async {
    final isar = await db;
    List<DiveGroup> dive_groups = await isar.diveGroups
        .filter()
        .dive((d) => d.idEqualTo(dive.id))
        .findAll();
    return dive_groups;
  }

  Future<bool> saveDiveGroup(Dive dive, DiveGroup diveGroup) async {
    final isar = await db;
    List<DiveGroup> dive_groups = await isar.diveGroups
        .filter()
        .dive((d) => d.idEqualTo(dive.id))
        .titleEqualTo(diveGroup.title)
        .findAll();
    if (dive_groups.isEmpty) {
      isar.writeTxnSync(() => isar.diveGroups.putSync(diveGroup));
      return true;
    } else {
      return false;
    }
  }

  Future<bool> upDateDiveGroup(Dive dive, DiveGroup diveGroup) async {
    final isar = await db;
    List<DiveGroup> dive_groups = await isar.diveGroups
        .filter()
        .dive((d) => d.idEqualTo(dive.id))
        .titleEqualTo(diveGroup.title)
        .findAll();
    if (dive_groups.isNotEmpty) {
      isar.writeTxnSync(() => isar.diveGroups.putSync(diveGroup));
      return true;
    } else {
      return false;
    }
  }

  Future<void> updateDiveGroupe(DiveGroup diveGroup) async {
    final isar = await db;
    isar.writeTxnSync(() => isar.diveGroups.putSync(diveGroup));
  }

  Future<void> removeParticipantsInGroupDive(
      Participant participant, DiveGroup diveGroup) async {
    final isar = await db;
    List<Participant> participants = await isar.participants
        .filter()
        .diveGroups((q) => q.idEqualTo(diveGroup.id))
        .idEqualTo(participant.id)
        .findAll();
    if (participants.length == 1) {
      diveGroup.participants.remove(participants[0]);
      isar.writeTxnSync(() => isar.diveGroups.putSync(diveGroup));
    }
  }
}
