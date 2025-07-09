part of 'RechazoAllBloc.dart';

abstract class RechazoAllState {}

class RechazoAllInitial extends RechazoAllState {}

class RechazoAllLoading extends RechazoAllState {}

class RechazoAllSuccess extends RechazoAllState {}

class RechazoAllFailure extends RechazoAllState {
  final String error;

  RechazoAllFailure(this.error);
}