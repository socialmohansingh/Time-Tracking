part of 'worked_hours_cubit.dart';

@immutable
abstract class WorkedHoursState {}

class AddWorkedHoursInitial extends WorkedHoursState {}

class WorkedHoursAddedState extends WorkedHoursState {
  final String success;

  WorkedHoursAddedState(this.success);
}

class WorkedHoursDeletedState extends WorkedHoursState {
  final String success;

  WorkedHoursDeletedState(this.success);
}

class WorkedHoursError extends WorkedHoursState {
  final String error;

  WorkedHoursError(this.error);
}

class WorkedHoursLoading extends WorkedHoursState {}

class LogDateValidationError extends WorkedHoursState {}

class HoursValidationError extends WorkedHoursState {}