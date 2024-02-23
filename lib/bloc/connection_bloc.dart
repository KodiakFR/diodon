import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:diodon/services/isar_service.dart';
import 'package:path_provider/path_provider.dart';

import '../entities/user.dart';

class ConnexionBloc extends Cubit<Connexion> {
  ConnexionBloc(Connexion initialState) : super(initialState);
  IsarService isarService = IsarService();

  void addUsers(List<User> users) {
    state.users = users;
    emit(state);
  }

  Future<bool> deleteUser(User user) async {
    bool result = false;
    if (state.users != null) {
      result = await isarService.deleteUser(user);
      if (result) {
        Directory? dir = await getExternalStorageDirectory();
        String dirPath = "";
        if (dir != null) {
          dirPath = dir.path;
        }
        File fileSignature =
            File("$dirPath/Signature_${user.name}_${user.firstName}.png");
        File fileStamp =
            File("$dirPath/Stamp_${user.name}_${user.firstName}.png");
        if (fileSignature.existsSync() && fileStamp.existsSync()) {
          await fileStamp.delete();
          await fileSignature.delete();
        }else{
          print("error");
        }

        Connexion newState = state.copyWith(
            users: state.users, connectedUser: state.connectedUser);
        newState.users!.remove(user);
        emit(newState);
      }
    }

    return result;
  }

  void logIn(User user) {
    state.connectedUser = user;
    emit(state);
  }

  void logOut() {
    state.connectedUser = User.empty();
    emit(state);
  }
}

class Connexion {
  List<User>? users;
  User? connectedUser;

  Connexion(this.users, this.connectedUser);

  Connexion.empty();

  Connexion copyWith({
    final List<User>? users,
    final User? connectedUser,
  }) {
    return Connexion(users ?? this.users, connectedUser ?? this.connectedUser);
  }
}
