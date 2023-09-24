import 'package:diodon/entities/user.dart';
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
        [UserSchema],
        inspector: true,
        directory: dir.path,
      );
    }
    return Future.value(Isar.getInstance());
  }

  Future<void> saveUser(User user) async {
    final isar = await db;
    isar.writeTxnSync(() => isar.users.putSync(user));
  }

  Future<List<User>> getAllUsers() async {
    final isar = await db;
    return await isar.users.where().findAll();
  }

  Future<bool> connexionUser(String mdp, int id)async{
    final isar = await db;
    final List<User> users = await isar.users.filter().idEqualTo(id).passwordEqualTo(mdp).findAll();
    if(users.length == 1){
      return true;
    }else{
      return false;
    }
  }
}
