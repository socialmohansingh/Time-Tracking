import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:time_tracking/modules/kanban/ticket/data/entity/user_model.dart';
import 'package:time_tracking/modules/kanban/ticket/domain/usecase/ticket_usecase.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetUserDataUseCase _useCase;
  TaskBloc(this._useCase) : super(TaskInitial()) {
    on<GetAllUserEvent>((event, emit) async {
      emit(TaskLoading());
      await emit.forEach(_useCase.call(), onData: (data) {
        return data.fold(
          (error) => TaskLoadingError(),
          (data) => UserListDate(data),
        );
      }, onError: ((error, stackTrace) {
        return TaskLoadingError();
      }));
    });
  }
}
