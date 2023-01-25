import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:time_tracking/modules/kanban/ticket/data/entity/worked_hour_model.dart';
import 'package:time_tracking/modules/kanban/worked_hours/domain/usecase/work_hour_usecase.dart';

part 'get_worked_hour_state.dart';
part 'get_worked_hour_event.dart';

class GetWorkedHourBloc extends Bloc<GetWorkedHourEvent, GetWorkedHourState> {
  final AllWorkedHoursUseCase _allWorkedHoursData;
  GetWorkedHourBloc(this._allWorkedHoursData) : super(GetWorkedHourInitial()) {
    on<GetDataWorkedHourEvent>((event, emit) async {
      emit(GetWorkedHourLoading());

      await emit.forEach(
          _allWorkedHoursData.call(ticketDocId: event.ticketDocId),
          onError: (error, stackTrace) => GetWorkedHourError('Error Occured'),
          onData: (data) {
            return GetWorkedHourData(data);
          });
    });
  }
}
