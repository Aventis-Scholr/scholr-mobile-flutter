part of 'ScholarshipsBloc.dart';

abstract class ScholarshipsEvent {

}

class ScholarshipsInitialFetchEvent extends ScholarshipsEvent {

}

class ScholarshipsSearchEvent extends ScholarshipsEvent {
  final String query;
  ScholarshipsSearchEvent(this.query);
}

class ScholarshipsFilterByTypeEvent extends ScholarshipsEvent {
  final String type;
  ScholarshipsFilterByTypeEvent(this.type);
}