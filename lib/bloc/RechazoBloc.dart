import 'dart:async';
import 'package:bloc/bloc.dart';

import '../repository/RechazoRepository.dart';


part 'RechazoEvent.dart';
part 'RechazoState.dart';


class RechazoBloc extends Bloc<RechazoEvent, RechazoState> {
  final RechazoRepository repository;

  RechazoBloc(this.repository) : super(RechazoInitial()) {
    on<RechazarPostulacionEvent>(_onRechazarPostulacion);
  }

  FutureOr<void> _onRechazarPostulacion(
      RechazarPostulacionEvent event,
      Emitter<RechazoState> emit,
      ) async {
    emit(RechazoLoading());

    try {
      await repository.rechazarPostulacion(
        postulacionId: event.postulacionId,
        reporte: event.reporte,
      );
      emit(RechazoSuccess());
    } catch (e) {
      emit(RechazoFailure(e.toString()));
    }
  }
}