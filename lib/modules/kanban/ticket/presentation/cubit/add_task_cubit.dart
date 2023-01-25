import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:time_tracking/modules/kanban/kanban_board/model/kanban_model.dart';
import 'package:time_tracking/modules/kanban/ticket/domain/usecase/ticket_usecase.dart';

part 'add_task_state.dart';

class AddTaskCubit extends Cubit<AddTaskState> {
  final CreateTaskUseCase _createTaskUseCase;

  final DeleteTicketUseCase _deleteTicketUseCase;

  final UpdateTicketUseCase _updateTicketUseCase;
  AddTaskCubit(this._createTaskUseCase, this._updateTicketUseCase,
      this._deleteTicketUseCase)
      : super(AddTaskInitial());

  Future<void> storeSingleTask({required KanbanModel taskdata}) async {
    if (taskdata.assignee.isEmpty) {
      emit(TaskAssigneeValidation());
      return;
    } else if (taskdata.name.isEmpty) {
      emit(TaskNameValidation());
      return;
    } else if (taskdata.hours.isEmpty) {
      emit(TaskHoursValidation());
      return;
    }
    emit(AddTaskLoading());
    final response = await _createTaskUseCase.execute(
      params: taskdata,
    );
    response.fold((error) => emit(AddTaskError(error)),
        (data) => emit(AddTaskData(data)));
  }

  Future<void> updateTicket({required KanbanModel taskdata}) async {
    if (taskdata.assignee.isEmpty) {
      emit(TaskAssigneeValidation());
      return;
    } else if (taskdata.name.isEmpty) {
      emit(TaskNameValidation());
      return;
    } else if (taskdata.hours.isEmpty) {
      emit(TaskHoursValidation());
      return;
    }
    emit(AddTaskLoading());
    final response = await _updateTicketUseCase.execute(
      params: taskdata,
    );
    response.fold((error) => emit(AddTaskError(error)),
        (data) => emit(UpdateSuccessState(data)));
  }

  Future<void> deleteTicket({required String docId}) async {
    await _deleteTicketUseCase.execute(params: docId);
  }
}
