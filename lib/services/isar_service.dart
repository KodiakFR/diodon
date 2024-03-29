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

  Future<bool> existUser(User user) async {
    final isar = await db;
    final List<User> users = await isar.users
        .filter()
        .firstNameEqualTo(user.firstName)
        .nameEqualTo(user.name)
        .findAll();
    if (users.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<bool> deleteUser(User user) async {
    final isar = await db;
    bool result = await isar.writeTxn(() => isar.users.delete(user.id));
    return result;
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

  Future<bool> updateWeekend(Weekend weekend) async {
    final isar = await db;
    final List<Weekend> weekends =
        await isar.weekends.filter().idEqualTo(weekend.id).findAll();
    if (weekends.length == 1) {
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

    List<DiveGroup> diveGroups = await isar.diveGroups
        .filter()
        .dive((q) => q.weekend((q) => q.idEqualTo(weekend.id)))
        .findAll();

    for (var diveGroup in diveGroups) {
      isar.writeTxnSync(() => isar.diveGroups.deleteSync(diveGroup.id));
    }

    List<Dive> dives = await isar.dives
        .filter()
        .weekend((q) => q.idEqualTo(weekend.id))
        .findAll();

    for (var dive in dives) {
      isar.writeTxnSync(() => isar.dives.deleteSync(dive.id));
    }

    List<Participant> participants = await isar.participants
        .filter()
        .weekends((q) => q.idEqualTo(weekend.id))
        .findAll();

    for (var participant in participants) {
      if (participant.weekends.isEmpty) {
        isar.writeTxnSync(() => isar.participants.deleteSync(participant.id));
      }
    }

    final success =
        isar.writeTxnSync(() => isar.weekends.deleteSync(weekend.id!));

    return success;
  }

  Future<Weekend?> getWeekendFromDive(Dive dive) async {
    final isar = await db;

    final List<Weekend> weekends = await isar.weekends
        .filter()
        .dives((q) => q.idEqualTo(dive.id))
        .findAll();
    return weekends.first;
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
    List<Participant> participants = await isar.participants
        .filter()
        .firstNameEqualTo(participant.firstName)
        .nameEqualTo(participant.name)
        .findAll();
    if (participants.isEmpty) {
      isar.writeTxnSync<int>(() => isar.participants.putSync(participant));
      return true;
    } else {
      final Participant participantExist = participants.first;
      participants = await isar.participants
          .filter()
          .weekends((q) => q.idEqualTo(weekend.id))
          .firstNameEqualTo(participant.firstName)
          .nameEqualTo(participant.name)
          .findAll();
      if (participants.isNotEmpty) {
        return false;
      } else {
        participantExist.weekends.add(weekend);
        isar.writeTxnSync(() => isar.participants.putSync(participantExist));
        return true;
      }
    }
  }

  Future<bool> removeParticipantsInWeekend(
      Participant participant, Weekend weekend) async {
    bool result = false;
    final isar = await db;
    List<Participant> participants = await isar.participants
        .filter()
        .weekends((q) => q.idEqualTo(weekend.id))
        .idEqualTo(participant.id)
        .findAll();
    if (participants.length == 1) {
      await isar.writeTxn(() async {
        await isar.participants.delete(participants[0].id);
        result = true;
      });
    }
    return result;
  }

  Future<bool> upDateParticipant(Participant participant) async {
    bool result = false;
    final isar = await db;
    int id = isar.writeTxnSync(() => isar.participants.putSync(participant));
    if (id == participant.id) {
      result = true;
    }
    return result;
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

  Future<Dive> getDiveById(Dive dive) async {
    final isar = await db;
    List<Dive> dives = await isar.dives.filter().idEqualTo(dive.id).findAll();
    return dives.first;
  }

  Future<bool> updateDive(Dive dive) async {
    final isar = await db;
    final List<Dive> dives =
        await isar.dives.filter().idEqualTo(dive.id).findAll();
    if (dives.length == 1) {
      isar.writeTxnSync<int>(() => isar.dives.putSync(dive));
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteDive(Dive dive, Weekend weekend) async {
    final isar = await db;
    bool sucess = false;
    List<DiveGroup> diveGroups = await isar.diveGroups
        .filter()
        .dive((q) => q.idEqualTo(dive.id))
        .findAll();
    for (var diveGroup in diveGroups) {
      isar.writeTxnSync(() => isar.diveGroups.deleteSync(diveGroup.id));
    }
    sucess = await isar.writeTxnSync(() => isar.dives.deleteSync(dive.id));
    if (sucess) {
      int index = int.parse(dive.title.split(" ")[2]) - 1;
      List<Dive> dives = await isar.dives
          .filter()
          .weekend((q) => q.idEqualTo(weekend.id))
          .findAll();
      for (var i = index; i < dives.length; i++) {
        dives[i].title = "Plongée N° ${i + 1}";
        isar.writeTxnSync(() => isar.dives.putSync(dives[i]));
      }
    }

    return sucess;
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
        .sortBySort()
        .findAll();
    return particiapants;
  }

  Future<List<DiveGroup>> getAllDiveGroupForDive(Dive dive) async {
    final isar = await db;
    List<DiveGroup> diveGroups = await isar.diveGroups
        .filter()
        .dive((d) => d.idEqualTo(dive.id))
        .findAll();
    return diveGroups;
  }

  Future<bool> saveDiveGroup(Dive dive, DiveGroup diveGroup) async {
    final isar = await db;
    List<DiveGroup> diveGroups = await isar.diveGroups
        .filter()
        .dive((d) => d.idEqualTo(dive.id))
        .titleEqualTo(diveGroup.title)
        .findAll();
    if (diveGroups.isEmpty) {
      isar.writeTxnSync(() => isar.diveGroups.putSync(diveGroup));
      return true;
    } else {
      return false;
    }
  }

  Future<bool> upDateDiveGroup(Dive dive, DiveGroup diveGroup) async {
    final isar = await db;
    List<DiveGroup> diveGroups = await isar.diveGroups
        .filter()
        .dive((d) => d.idEqualTo(dive.id))
        .titleEqualTo(diveGroup.title)
        .findAll();
    if (diveGroups.isNotEmpty) {
      isar.writeTxnSync(() => isar.diveGroups.putSync(diveGroup));
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateDiveGroupe(DiveGroup diveGroup) async {
    bool result = false;
    final isar = await db;
    int id = isar.writeTxnSync(() => isar.diveGroups.putSync(diveGroup));
    if (id == diveGroup.id) {
      result = true;
    }
    return result;
  }

  Future<bool> removeParticipantsInGroupDive(
      Participant participant, DiveGroup diveGroup) async {
    bool result = false;
    final isar = await db;
    List<Participant> participants = await isar.participants
        .filter()
        .diveGroups((q) => q.idEqualTo(diveGroup.id))
        .idEqualTo(participant.id)
        .findAll();
    if (participants.length == 1) {
      diveGroup.participants.remove(participants[0]);
      int id = isar.writeTxnSync(() => isar.diveGroups.putSync(diveGroup));
      if (id == diveGroup.id) {
        result = true;
      }
    }
    return result;
  }

  Future<bool> isInDiveGroup(Dive dive, Participant participant) async {
    final isar = await db;
    List<Participant> participants = await isar.participants
        .filter()
        .nameEqualTo(participant.name)
        .firstNameEqualTo(participant.firstName)
        .diveGroups((dg) => dg.dive((d) => d.idEqualTo(dive.id)))
        .findAll();
    if (participants.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<bool> deleteDiveGroup(DiveGroup diveGroup, Dive dive) async {
    final isar = await db;
    List<Participant> participants = await isar.participants
        .filter()
        .diveGroups((q) => q.idEqualTo(diveGroup.id))
        .findAll();
    if (participants.isNotEmpty) {
      return false;
    } else {
      await isar.writeTxn(() async {
        await isar.diveGroups.delete(diveGroup.id);
      });
      List<DiveGroup> diveGroups = await isar.diveGroups
          .filter()
          .dive((d) => d.idEqualTo(dive.id))
          .findAll();
      int index = int.parse(diveGroup.title!.split(" ")[1]) - 1;
      if (index <= diveGroups.length) {
        for (var i = index; i < diveGroups.length; i++) {
          diveGroups[i].title = "Palanquée ${i + 1}";
          isar.writeTxnSync(() => isar.diveGroups.putSync(diveGroups[i]));
        }
      }

      return true;
    }
  }

  Future<List<Participant>> getAllDiverForDiveGroup(DiveGroup diveGroup) async {
    final isar = await db;
    List<Participant> participants = await isar.participants
        .filter()
        .diveGroups((q) => q.idEqualTo(diveGroup.id))
        .findAll();
    return participants;
  }
}
