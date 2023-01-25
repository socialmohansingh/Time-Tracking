part of 'get_worked_hour_cubit.dart';

@immutable
abstract class GetWorkedHourEvent {}

class GetDataWorkedHourEvent extends GetWorkedHourEvent {
  final String ticketDocId;

  GetDataWorkedHourEvent(this.ticketDocId);
}
