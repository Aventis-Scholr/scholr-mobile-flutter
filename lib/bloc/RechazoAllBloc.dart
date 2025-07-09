import 'dart:async';
import 'package:bloc/bloc.dart';
import '../repository/RechazoAllRepository.dart';

part 'RechazoAllEvent.dart';
part 'RechazoAllState.dart';

class RechazoAllBloc extends Bloc<RechazoAllEvent, RechazoAllState> {
  final RechazoAllRepository repository;

  RechazoAllBloc(this.repository) : super(RechazoAllInitial()) {
    on<RechazarAllPostulacionesEvent>(_onRechazarAllPostulaciones);
  }

  FutureOr<void> _onRechazarAllPostulaciones(
      RechazarAllPostulacionesEvent event,
      Emitter<RechazoAllState> emit,
      ) async {
    emit(RechazoAllLoading());

    try {
      await repository.rechazarAllPostulaciones(
        apoderadoId: event.apoderadoId,
        reporte: event.reporte,
      );
      emit(RechazoAllSuccess());
    } catch (e) {
      emit(RechazoAllFailure(e.toString()));
    }
  }
}