part of 'ScholarshipsBloc.dart';

abstract class ScholarshipsState {

}

abstract class ScholarshipsActionState extends ScholarshipsState {

}

class ScholarshipsInitial extends ScholarshipsState {

}

class ScholarshipsFetchingSuccessfulState extends ScholarshipsState {

  final List<Scholarship> scholarships;

  ScholarshipsFetchingSuccessfulState({
    required this.scholarships
  });

}