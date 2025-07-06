

abstract class ApoderadoEvent {
  const ApoderadoEvent();

  List<Object> get props => [];
}

class FetchApoderados extends ApoderadoEvent {
  final int scholarshipId;

  const FetchApoderados(this.scholarshipId);

  @override
  List<Object> get props => [scholarshipId];
}
