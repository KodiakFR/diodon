import 'package:bloc/bloc.dart';
import 'package:diodon/entities/dive.dart';
import 'package:diodon/entities/weekend.dart';

import '../services/isar_service.dart';

class DivesBloc extends Cubit<List<Dive>> {
  DivesBloc(List<Dive> initialState) : super(initialState);
  final IsarService isarService = IsarService();

  void initDives(List<Dive> dives) {
    emit(dives);
  }

  Future<bool> deleteDive(Dive dive, Weekend weekend) async {
    bool result = await isarService.deleteDive(dive, weekend);
    if (result) {
      List<Dive> dives = await isarService.getAllDiveByWeekend(weekend);
      emit(dives);
    }
    return result;
  }
}
