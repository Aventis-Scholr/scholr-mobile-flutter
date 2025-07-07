part of 'AcceptanceBloc.dart';

abstract class AcceptanceState {}

class AcceptanceInitial extends AcceptanceState {}

class AcceptanceLoading extends AcceptanceState {}

class AcceptanceSuccess extends AcceptanceState {}

class AcceptanceFailure extends AcceptanceState {
  final String error;

  AcceptanceFailure(this.error);
}