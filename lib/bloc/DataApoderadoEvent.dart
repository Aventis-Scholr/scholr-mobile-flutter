part of 'DataApoderadoBloc.dart';

abstract class DataApoderadoEvent {}

class DataApoderadoInitialFetchEvent extends DataApoderadoEvent {
  final int id;
  DataApoderadoInitialFetchEvent(this.id);
}