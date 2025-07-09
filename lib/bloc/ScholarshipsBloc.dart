import 'dart:async';
import 'package:bloc/bloc.dart';
import '../repository/ScholarshipRepos.dart';
import '../models/scholarship.dart';

part 'ScholarshipsEvent.dart';
part 'ScholarshipsState.dart';

class ScholarshipsBloc extends Bloc<ScholarshipsEvent, ScholarshipsState> {
  List<Scholarship> _allScholarships = [];
  String _currentSearchQuery = '';
  String _currentTypeFilter = '';

  ScholarshipsBloc() : super(ScholarshipsInitial()) {
    on<ScholarshipsInitialFetchEvent>(_fetchInitialScholarships);
    on<ScholarshipsSearchEvent>(_handleSearch);
    on<ScholarshipsFilterByTypeEvent>(_handleTypeFilter);
  }

  Future<void> _fetchInitialScholarships(
      ScholarshipsInitialFetchEvent event,
      Emitter<ScholarshipsState> emit
      ) async {
    emit(ScholarshipsLoadingState());
    try {
      _allScholarships = await ScholarshipRepos.fetchScholarshipsFromCompany("BACKUS");
      emit(ScholarshipsFetchingSuccessfulState(
          scholarships: _applyFilters()
      ));
    } catch (e) {
      emit(ScholarshipsErrorState(error: e.toString()));
    }
  }

  void _handleSearch(
      ScholarshipsSearchEvent event,
      Emitter<ScholarshipsState> emit
      ) {
    _currentSearchQuery = event.query;
    emit(ScholarshipsFetchingSuccessfulState(
        scholarships: _applyFilters()
    ));
  }

  void _handleTypeFilter(
      ScholarshipsFilterByTypeEvent event,
      Emitter<ScholarshipsState> emit
      ) {
    _currentTypeFilter = event.type;
    emit(ScholarshipsFetchingSuccessfulState(
        scholarships: _applyFilters()
    ));
  }

  List<Scholarship> _applyFilters() {
    List<Scholarship> filtered = List.from(_allScholarships);

    // Apply search filter
    if (_currentSearchQuery.isNotEmpty) {
      filtered = filtered.where((scholarship) =>
          scholarship.name.toLowerCase().contains(_currentSearchQuery.toLowerCase())
      ).toList();
    }

    // Apply type filter
    if (_currentTypeFilter.isNotEmpty) {
      filtered = filtered.where((scholarship) =>
      scholarship.scholarshipType == _currentTypeFilter
      ).toList();
    }

    return filtered;
  }
}