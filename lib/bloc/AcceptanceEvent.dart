part of 'AcceptanceBloc.dart';

abstract class AcceptanceEvent {}

class AcceptApplicationEvent extends AcceptanceEvent {
  final int postulacionId;

  AcceptApplicationEvent(this.postulacionId);
}