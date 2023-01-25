part of 'task_bloc.dart';

@immutable
abstract class TaskState {}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class UserListDate extends TaskState {
  final List<UserModel> userModel;

  UserListDate(this.userModel);
}

class TaskLoadingError extends TaskState {}
