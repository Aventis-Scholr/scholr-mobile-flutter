import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:scholrflutter/models/apoderado.dart';
import 'package:scholrflutter/repository/ApoderadoRepos.dart';

part 'DataApoderadoEvent.dart';
part 'DataApoderadoState.dart';

class DataApoderadoBloc extends Bloc<DataApoderadoEvent, DataApoderadoState> {
  DataApoderadoBloc() : super(DataApoderadoInitial()) {
    on<DataApoderadoInitialFetchEvent>(_dataApoderadoInitialFetchEvent);
  }

  FutureOr<void> _dataApoderadoInitialFetchEvent(
      DataApoderadoInitialFetchEvent event,
      Emitter<DataApoderadoState> emit,
      ) async {
    try {
      final dataApoderado = await ApoderadoRepository().fetchDataApoderado(event.id);
      emit(DataApoderadoFetchingSuccessfulState(dataApoderado: dataApoderado));
    } catch (e) {
      emit(DataApoderadoFetchingErrorState(message: e.toString()));
    }
  }
}

