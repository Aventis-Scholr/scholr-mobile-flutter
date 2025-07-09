part of 'RechazoAllBloc.dart';

abstract class RechazoAllEvent {}

class RechazarAllPostulacionesEvent extends RechazoAllEvent {
  final int apoderadoId;
  final String reporte;

  RechazarAllPostulacionesEvent({
    required this.apoderadoId,
    required this.reporte,
  });
}