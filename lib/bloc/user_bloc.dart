import 'package:bloc/bloc.dart';

import '../entities/user.dart';

class UserBloc extends Cubit<User>{
  UserBloc(User initialState): super(initialState);


void logIn(User user){
  emit(user);
}

void logOut(){
  User user = User.empty();
  emit(user);
}


} 