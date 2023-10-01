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
      isar.writeTxnSync(() => isar.users.putSync(user));
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
    DateTime onYearAgo = DateTime(now.year-1,now.month,now.day);
    final List<Weekend> weekends = await isar.weekends.filter().endGreaterThan(onYearAgo).findAll();
    return weekends;
  }
}
