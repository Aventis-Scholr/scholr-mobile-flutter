import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/ApoderadoRepos.dart';
import 'ApoderadosEvent.dart';
import 'ApoderadosState.dart';

class ApoderadoBloc extends Bloc<ApoderadoEvent, ApoderadoState> {
  final ApoderadoRepository repository;

  ApoderadoBloc({required this.repository}) : super(ApoderadoInitial()) {
    on<FetchApoderados>((event, emit) async {
      emit(ApoderadoLoading());
      try {
        final apoderados = await repository.fetchApoderadosForScholarship(event.scholarshipId);
        emit(ApoderadoLoaded(apoderados));
      } catch (e) {
        emit(ApoderadoError('Failed to load apoderados'));
      }
    });

  }
}
