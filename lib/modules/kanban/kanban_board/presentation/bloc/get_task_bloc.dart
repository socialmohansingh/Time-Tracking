import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:time_tracking/modules/kanban/kanban_board/domain/usecase/kanban_usecase.dart';
import 'package:time_tracking/modules/kanban/kanban_board/model/kanban_model.dart';
import 'package:time_tracking/modules/kanban/kanban_board/model/move_model.dart';

part 'get_task_event.dart';
part 'get_task_state.dart';

class GetTaskBloc extends Bloc<GetTaskEvent, GetTaskState> {
  final FetchAllTaskUseCase _fetchAllTaskUseCase;

  final MoveTicketUsecase _moveTicketUsecase;
  GetTaskBloc(this._fetchAllTaskUseCase, this._moveTicketUsecase)
      : super(GetTaskInitial()) {
    on<GetAllTicketEvent>((event, emit) async {
      emit(GetTaskLoading());

      await emit.forEach(
        _fetchAllTaskUseCase.call(),
        onError: (error, stackTrace) => (GetTaskError('$error')),
        onData: (data) {
          return AllTaskState(data);
        },
      );
    });
    on<MoveTicketEvent>((event, emit) async {
      
          await _moveTicketUsecase.execute(params: event.moveData);
    });
  }
}
