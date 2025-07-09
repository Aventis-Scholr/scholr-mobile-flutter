part of 'ScholarshipsBloc.dart';

abstract class ScholarshipsState {}

class ScholarshipsInitial extends ScholarshipsState {}

class ScholarshipsLoadingState extends ScholarshipsState {}

class ScholarshipsFetchingSuccessfulState extends ScholarshipsState {
  final List<Scholarship> scholarships;

  ScholarshipsFetchingSuccessfulState({
    required this.scholarships
  });
}

class ScholarshipsErrorState extends ScholarshipsState {
  final String error;

  ScholarshipsErrorState({
    required this.error
  });
}