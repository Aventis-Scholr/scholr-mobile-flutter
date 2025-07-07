part of 'RechazoBloc.dart';

abstract class RechazoEvent {}

class RechazarPostulacionEvent extends RechazoEvent {
  final int postulacionId;
  final String reporte;

  RechazarPostulacionEvent({
    required this.postulacionId,
    required this.reporte,
  });
}