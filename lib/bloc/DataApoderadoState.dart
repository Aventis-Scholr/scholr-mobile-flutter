part of 'DataApoderadoBloc.dart';

abstract class DataApoderadoState {}

abstract class DataApoderadoActionState extends DataApoderadoState {

}

class DataApoderadoInitial extends DataApoderadoState {

}

class DataApoderadoLoading extends DataApoderadoState {}

class DataApoderadoLoaded extends DataApoderadoState {
  final DataApoderado apoderado;

  DataApoderadoLoaded({
    required this.apoderado
  });
}

class DataApoderadoError extends DataApoderadoState {
  final String message;

  DataApoderadoError({
    required this.message
  });
}

class DataApoderadoFetchingSuccessfulState extends DataApoderadoState {

  final DataApoderado dataApoderado;

  DataApoderadoFetchingSuccessfulState({
    required this.dataApoderado
  });

}

class DataApoderadoFetchingErrorState extends DataApoderadoState {
  final String message;
  DataApoderadoFetchingErrorState({required this.message});
}