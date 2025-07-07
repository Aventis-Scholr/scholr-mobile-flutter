import 'dart:async';
import 'package:bloc/bloc.dart';

import '../repository/AcceptanceRepository.dart';

part 'AcceptanceEvent.dart';
part 'AcceptanceState.dart';

class AcceptanceBloc extends Bloc<AcceptanceEvent, AcceptanceState> {
  final AcceptanceRepository repository;

  AcceptanceBloc(this.repository) : super(AcceptanceInitial()) {
    on<AcceptApplicationEvent>(_onAcceptApplication);
  }

  FutureOr<void> _onAcceptApplication(
      AcceptApplicationEvent event,
      Emitter<AcceptanceState> emit,
      ) async {
    emit(AcceptanceLoading());
    try {
      await repository.acceptApplication(event.postulacionId);
      emit(AcceptanceSuccess());
    } catch (e) {
      emit(AcceptanceFailure(e.toString()));
    }
  }
}