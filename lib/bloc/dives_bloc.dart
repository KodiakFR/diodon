import 'package:bloc/bloc.dart';
import 'package:diodon/entities/dive.dart';

import '../services/isar_service.dart';

class DivesBloc extends Cubit<List<Dive>> {
  DivesBloc(List<Dive> initialState) : super(initialState);
  final IsarService isarService = IsarService();

  void initDives(List<Dive> dives) {
    emit(dives);
  }

  Future<bool> deleteDive(Dive dive) async {
    bool result = await isarService.deleteDive(dive);
    if (result) {
      List<Dive> dives = state;
      dives.remove(dive);
      emit(dives);
    }
    return result;
  }
}
