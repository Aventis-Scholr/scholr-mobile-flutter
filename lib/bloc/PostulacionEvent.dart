part of 'PostulacionBloc.dart';

abstract class PostulacionEvent {}

class FetchPostulacionesEvent extends PostulacionEvent {
  final int apoderadoId;

  FetchPostulacionesEvent(this.apoderadoId);
}