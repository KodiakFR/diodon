import 'package:diodon/entities/dive_group.dart';
import 'package:diodon/entities/participant.dart';
import 'package:diodon/services/isar_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../entities/dive.dart';

class DiveDetailBloc extends Cubit<DiveDetailModel> {
  DiveDetailBloc(DiveDetailModel initialState) : super(initialState);
  IsarService isarService = IsarService();

  void initDiver(List<Participant> divers) {
    state.divers = divers;
    emit(state);
  }

  void initDiverGroup(List<DiveGroup> divegroups) {
    state.divegroups = divegroups;
    emit(state);
  }

  Future<bool> isInDiveGroup(Dive dive, Participant participant) async {
    bool result = await isarService.isInDiveGroup(dive, participant);
    if (!result) {
      state.divers!
              .where((element) => element.id == participant.id)
              .first
              .selected =
          !state.divers!
              .where((element) => element.id == participant.id)
              .first
              .selected!;
      emit(state);
    }
    return result;
  }

  Future<void> newDiveGroup(Dive dive) async {
    List<DiveGroup> diveGroups = await isarService.getAllDiveGroupForDive(dive);
    int numberDiveGroup = diveGroups.length + 1;
    DiveGroup diveGroup = DiveGroup()
      ..dive.value = dive
      ..title = "Palanquée $numberDiveGroup"
      ..divingStop = ""
      ..dpDeep = ""
      ..dpTime = ""
      ..hourImmersion = DateTime(1970)
      ..realDeep = ""
      ..realTime = ""
      ..riseHour = DateTime(1970)
      ..standAlone = false
      ..supervised = false;

    bool isSaved = await isarService.saveDiveGroup(dive, diveGroup);
    if (isSaved) {
      DiveDetailModel newState =
          DiveDetailModel(state.divers, state.divegroups);
      newState.divegroups!.add(diveGroup);
      emit(newState);
    }
  }

  Future<bool> deleteDiveGroup(DiveGroup diveGroup, Dive dive) async {
    bool result = await isarService.deleteDiveGroup(diveGroup, dive);
    if (result) {
      DiveDetailModel newState =
          DiveDetailModel(state.divers, state.divegroups);
      List<DiveGroup> diveGroups =
          await isarService.getAllDiveGroupForDive(dive);
      newState.divegroups = diveGroups;
      emit(newState);
    }
    return result;
  }

  Future<void> updateParamters(Dive dive, DiveGroup diveGroup) async {
    bool result = await isarService.upDateDiveGroup(dive, diveGroup);
    if (result) {
      DiveDetailModel newState =
          DiveDetailModel(state.divers, state.divegroups);
      newState.divegroups!.add(diveGroup);
      emit(newState);
    }
  }

  Future<void> updateParticipant(Participant participant) async {
    bool result = await isarService.upDateParticipant(participant);
    if (result) {
      DiveDetailModel newState =
          DiveDetailModel(state.divers, state.divegroups);
      newState.divers!.add(participant);
      emit(newState);
    }
  }

  Future<void> updateDiveGroup(DiveGroup diveGroup) async {
    bool result = await isarService.updateDiveGroupe(diveGroup);
    if (result) {
      DiveDetailModel newState =
          DiveDetailModel(state.divers, state.divegroups);
      newState.divegroups!.add(diveGroup);
      emit(newState);
    }
  }

  Future<void> removeParticipantsInGroupDive(
      Participant participant, DiveGroup diveGroup) async {
    bool result =
        await isarService.removeParticipantsInGroupDive(participant, diveGroup);
    if (result) {
      DiveDetailModel newState =
          DiveDetailModel(state.divers, state.divegroups);
      newState.divegroups!.add(diveGroup);
      emit(newState);
    }
  }
}

class DiveDetailModel {
  List<Participant> divers;
  List<DiveGroup> divegroups;

  DiveDetailModel(this.divers, this.divegroups);

  
}
