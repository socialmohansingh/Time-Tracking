import 'package:flutter_core/flutter_core.dart';
import 'package:time_tracking/modules/kanban/ticket/data/entity/worked_hour_model.dart';
import 'package:time_tracking/modules/kanban/worked_hours/domain/repository/worked_hour_repository.dart';

class AllWorkedHoursUseCase extends BaseUseCase<Result<String, String>, void> {
  final WorkedHourRepository _repository;

  AllWorkedHoursUseCase(this._repository);
  @override
  Future<Result<String, String>> execute({void params}) {
    throw UnimplementedError();
  }

  Stream<List<WorkedHoursModel>> call({required String ticketDocId}) {
    return _repository.getLogList(ticketDocId: ticketDocId);
  }
}

class WorkedHourDeleteUseCase
    extends BaseUseCase<Result<String, String>, void> {
  final WorkedHourRepository _repository;

  WorkedHourDeleteUseCase(this._repository);
  @override
  Future<Result<String, String>> execute({void params}) {
    throw UnimplementedError();
  }

  Future<Result<String, String>> call(
      {required String workedHourId, required String docId}) {
    return _repository.deleteWorkedHours(
        workedHourId: workedHourId, docId: docId);
  }
}

class AddWorkedHourUseCase extends BaseUseCase<Result<String, String>, void> {
  final WorkedHourRepository _repository;

  AddWorkedHourUseCase(this._repository);
  @override
  Future<Result<String, String>> execute({void params}) {
    throw UnimplementedError();
  }

  Future<Result<String, String>> call(
      {required WorkedHoursModel logModel, required String docId}) {
    return _repository.storeWorkedHours(
      logdata: logModel,
      docId: docId,
    );
  }
}
