part of 'add_task_cubit.dart';

@immutable
abstract class AddTaskState {}

class AddTaskInitial extends AddTaskState {}

class AddTaskLoading extends AddTaskState {}


class AddTaskData extends AddTaskState {
  final String success;

  AddTaskData(this.success);
}
class UpdateSuccessState extends AddTaskState {
  final String updateMessage;

  UpdateSuccessState(this.updateMessage);
}
class AddTaskError extends AddTaskState {
  final String error;

  AddTaskError(this.error);
}
class TaskNameValidation extends AddTaskState {}
class TaskHoursValidation extends AddTaskState {}


class TaskAssigneeValidation extends AddTaskState {}
class TaskPriorityValidation extends AddTaskState {}
class TaskTypeValidation extends AddTaskState {}
class TaskColumnValidation extends AddTaskState {}



