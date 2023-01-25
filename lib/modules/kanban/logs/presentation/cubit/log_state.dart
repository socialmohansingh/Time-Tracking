part of 'log_cubit.dart';

@immutable
abstract class LogState {}

class LogInitial extends LogState {}

class LogDataState extends LogState {
  final List<LogModel> logList;

  LogDataState(this.logList);
}

class LogLoading extends LogState {}

class LogError extends LogState {
  final String error;

  LogError(this.error);
}
