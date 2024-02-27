import 'package:bloc/bloc.dart';
import 'package:diodon/entities/weekend.dart';

import '../entities/participant.dart';
import '../services/isar_service.dart';

class ParticipantsBloc extends Cubit<List<Participant>> {
  ParticipantsBloc(List<Participant> initialState) : super(initialState);
  final IsarService isarService = IsarService();

  void initParticipants(List<Participant> participants) {
    emit(participants);
  }

  Future<void> removeParticipant(
      Participant participant, Weekend weekend) async {
    bool result =
        await isarService.removeParticipantsInWeekend(participant, weekend);
    if (result) {
      List<Participant> participants = state;
      participants.remove(participant);
      emit(participants);
    }
  }

  Future<bool> addParticipant(Participant participant, Weekend weekend) async {
    bool result = await isarService.addParticipants(weekend, participant);
    if (result) {
      List<Participant> participants = state;
      participants.add(participant);
      emit(participants);
    }
    return result;
  }

  Future<void> updateParticipant(
      Participant participant, Weekend weekend) async {
    await isarService.upDateParticipant(participant);
    List<Participant> participants =
        await isarService.getParticipantsFromWeekend(weekend.id!);
    emit(participants);
  }
}
