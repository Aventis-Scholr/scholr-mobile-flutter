import 'dart:async';
import 'package:bloc/bloc.dart';
import '../models/postulacion.dart';
import '../repository/ApplicationRepos.dart';

part 'PostulacionState.dart';
part 'PostulacionEvent.dart';

class PostulacionBloc extends Bloc<PostulacionEvent, PostulacionState> {
  final PostulacionRepository repository;

  PostulacionBloc(this.repository) : super(PostulacionInitial()) {
    on<FetchPostulacionesEvent>(_onFetchPostulaciones);
  }

  FutureOr<void> _onFetchPostulaciones(
      FetchPostulacionesEvent event,
      Emitter<PostulacionState> emit
      ) async {
    emit(PostulacionLoading());

    try {
      final postulaciones = await repository.fetchPostulacionesForApoderado(event.apoderadoId);
      emit(PostulacionLoaded(postulaciones));
    } catch (e) {
      emit(PostulacionError(e.toString()));
    }
  }
}