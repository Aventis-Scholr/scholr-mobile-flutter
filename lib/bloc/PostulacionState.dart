part of 'PostulacionBloc.dart';

abstract class PostulacionState {}

class PostulacionInitial extends PostulacionState {}

class PostulacionLoading extends PostulacionState {}

class PostulacionLoaded extends PostulacionState {
  final List<Postulacion> postulaciones;

  PostulacionLoaded(this.postulaciones);
}

class PostulacionError extends PostulacionState {
  final String message;

  PostulacionError(this.message);
}