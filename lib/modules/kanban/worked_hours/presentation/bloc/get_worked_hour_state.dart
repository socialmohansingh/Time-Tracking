part of 'get_worked_hour_cubit.dart';

@immutable
abstract class GetWorkedHourState {}

class GetWorkedHourInitial extends GetWorkedHourState {}

class GetWorkedHourLoading extends GetWorkedHourState {}

class GetWorkedHourError extends GetWorkedHourState {
  final String error;

  GetWorkedHourError(this.error);
}

class GetWorkedHourData extends GetWorkedHourState {
  final List<WorkedHoursModel> logModel;

  GetWorkedHourData(this.logModel);
}
