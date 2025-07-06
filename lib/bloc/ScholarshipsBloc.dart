import 'dart:async';
import 'package:bloc/bloc.dart';
import '../repository/ScholarshipRepos.dart';
import '../models/scholarship.dart';

part 'ScholarshipsEvent.dart';
part 'ScholarshipsState.dart';

class ScholarshipsBloc extends Bloc<ScholarshipsEvent, ScholarshipsState> {

  ScholarshipsBloc():super(ScholarshipsInitial()){
    on<ScholarshipsInitialFetchEvent>(scholarshipsInitialFetchEvent);
  }


  FutureOr<void> scholarshipsInitialFetchEvent(ScholarshipsInitialFetchEvent event, Emitter<ScholarshipsState> emit) async {
    List<Scholarship> scholarships = await ScholarshipRepos.fetchScholarshipsFromCompany("BACKUS"); // Hardcoded
    emit(ScholarshipsFetchingSuccessfulState(scholarships: scholarships));

  }
}