part of 'RechazoBloc.dart';

abstract class RechazoState {}

class RechazoInitial extends RechazoState {}

class RechazoLoading extends RechazoState {}

class RechazoSuccess extends RechazoState {}

class RechazoFailure extends RechazoState {
  final String error;

  RechazoFailure(this.error);
}