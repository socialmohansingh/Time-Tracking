part of 'get_task_bloc.dart';

abstract class GetTaskEvent {}

class GetAllTicketEvent extends GetTaskEvent {}

class MoveTicketEvent extends GetTaskEvent {
  final MoveModel moveData;

  MoveTicketEvent(this.moveData);
}
