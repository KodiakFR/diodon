import 'dart:io';
import 'package:bloc/bloc.dart';

class RegisterBloc extends Cubit<Register> {
  RegisterBloc(Register initialState) : super(initialState);

  void changeFile(File file, String name) {
    Register newState = state.copyWith(files: state.files, firstname: state.firstname, mdpConfirm: state.mdpConfirm, mpd: state.mpd,name: state.name);
     newState.files.update(name, (value) => file);
    emit(newState);
  }

  void changeName(String value) {
    state.name = value;
    emit(state);
  }

  void changeFirstName(String value) {
    state.firstname = value;
    emit(state);
  }

  void changeMdp(String value) {
    state.mpd = value;
    emit(state);
  }

  void changeMdpConfirm(String value) {
    state.mdpConfirm = value;
    emit(state);
  }

  void initialState() {
    Register register = Register.empty();
    emit(register);
  }
}

class Register {
  Map<String, File?> files = {'stamp': null, "signature": null};
  String? name;
  String? firstname;
  String? mpd;
  String? mdpConfirm;

  Register(this.files, this.name, this.firstname, this.mpd, this.mdpConfirm);

  Register.empty();

  Register copyWith({
    final Map<String, File?>? files,
    final String? name,
    final String? firstname,
    final String? mpd,
    final String? mdpConfirm,
  }) {
    return Register(
      files ?? this.files,
      name ?? this.name,
      firstname ?? this.firstname,
      mpd ?? this.mpd,
      mdpConfirm ?? this.mdpConfirm,
    );
  }
}
