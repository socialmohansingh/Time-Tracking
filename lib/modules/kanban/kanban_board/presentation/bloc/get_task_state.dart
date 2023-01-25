part of 'get_task_bloc.dart';

abstract class GetTaskState {}

class GetTaskInitial extends GetTaskState {}

class GetTaskLoading extends GetTaskState {}

class AllTaskState extends GetTaskState {
  final LinkedHashMap<String, List<KanbanModel>> board;

  AllTaskState(this.board);
}

class GetTaskError extends GetTaskState {
  final String error;

  GetTaskError(this.error);
}
