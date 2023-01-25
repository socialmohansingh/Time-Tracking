import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:time_tracking/modules/kanban/ticket/data/entity/worked_hour_model.dart';
import 'package:time_tracking/modules/kanban/worked_hours/domain/usecase/work_hour_usecase.dart';

part 'worked_hours_state.dart';

class WorkedHoursCubit extends Cubit<WorkedHoursState> {
  final WorkedHourDeleteUseCase _hoursUseCase;

  final AddWorkedHourUseCase _addWorkedHourUseCase;
  WorkedHoursCubit(this._hoursUseCase, this._addWorkedHourUseCase)
      : super(AddWorkedHoursInitial());

  Future<void> deleteWorkedHours(
      {required String workedId, required String docId}) async {
    emit(WorkedHoursLoading());
    final response =
        await _hoursUseCase.call(workedHourId: workedId, docId: docId);
    response.fold(
      (error) => emit(WorkedHoursError(error)),
      (data) => emit(WorkedHoursDeletedState(data)),
    );
  }

  Future<void> storeWorkedHours(
      {required WorkedHoursModel logModel, required String docId}) async {
    if (logModel.logDate == null) {
      emit(LogDateValidationError());
      return;
    } else if (logModel.workedHours == 0.0) {
      emit(HoursValidationError());
      return;
    }

    emit(WorkedHoursLoading());
    final response =
        await _addWorkedHourUseCase.call(logModel: logModel, docId: docId);
    response.fold(
      (error) => emit(WorkedHoursError(error)),
      (data) => emit(WorkedHoursAddedState(data)),
    );
  }
}
