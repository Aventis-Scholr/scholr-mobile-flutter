import '../../models/apoderado.dart';

abstract class ApoderadoState {
  const ApoderadoState();

  @override
  List<Object> get props => [];
}

class ApoderadoInitial extends ApoderadoState {}

class ApoderadoLoading extends ApoderadoState {}

class ApoderadoLoaded extends ApoderadoState {
  final List<Apoderado> apoderados;

  const ApoderadoLoaded(this.apoderados);

  @override
  List<Object> get props => [apoderados];
}

class ApoderadoError extends ApoderadoState {
  final String message;

  const ApoderadoError(this.message);

  @override
  List<Object> get props => [message];
}
