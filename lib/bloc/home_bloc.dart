import 'package:bloc/bloc.dart';
import 'package:diodon/entities/weekend.dart';
import 'package:diodon/services/isar_service.dart';

class HomeBloc extends Cubit<Home> {
  HomeBloc(Home initialState) : super(initialState);
  final IsarService isarService = IsarService();

  void addWeekends(List<Weekend> weekends) {
    state.weekends = weekends;
    emit(state);
  }

  void removeWeekend(Weekend weekend) async {
    bool result = await isarService.deleteWeekend(weekend);
    if (result == true) {
      Home newState = state.copyWith(weekends: state.weekends);
      newState.weekends!.remove(weekend);
      emit(newState);
    }
  }
}

class Home {
  List<Weekend>? weekends;

  Home(this.weekends);

  Home.empty();

  Home copyWith({final List<Weekend>? weekends}) {
    return Home(weekends ?? this.weekends);
  }
}
