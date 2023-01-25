import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:time_tracking/modules/kanban/logs/domain/usecase/log_user_case.dart';
import 'package:time_tracking/modules/kanban/ticket/data/entity/log_model.dart';

part 'log_state.dart';
part 'log_event.dart';

class LogCubit extends Bloc<LogEvent, LogState> {
  final LogUseCase logUseCase;
  LogCubit(this.logUseCase) : super(LogInitial()) {
    on<LogFetchEvent>((event, emit) async {
      emit(LogLoading());

      await emit.forEach(
        logUseCase.call(docId: event.docId),
        onError: ((error, stackTrace) {
          return LogError('$error');
        }),
        onData: (data) {
          return LogDataState(data);
        },
      );
    });
  }
}
