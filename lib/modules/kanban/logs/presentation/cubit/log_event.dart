part of 'log_cubit.dart';

abstract class LogEvent {}

class LogFetchEvent extends LogEvent {
  final String docId;

  LogFetchEvent(this.docId);
}
