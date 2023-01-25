import 'package:time_tracking/modules/kanban/ticket/data/entity/worked_hour_model.dart';
import 'package:flutter_core/src/utils/result.dart';
import 'package:time_tracking/modules/kanban/worked_hours/data/worked_hours_remote_data_source.dart';
import 'package:time_tracking/modules/kanban/worked_hours/domain/repository/worked_hour_repository.dart';

class WorkedHourRepositoryImpl extends WorkedHourRepository {
  final WorkedHourRemoteDataSource _workedHourRemote;

  WorkedHourRepositoryImpl(this._workedHourRemote);
  @override
  Future<Result<String, String>> deleteWorkedHours(
      {required String workedHourId, required String docId}) async {
    return _workedHourRemote.deleteWorkedHours(
        workedHourId: workedHourId, docId: docId);
  }

  @override
  Future<Result<String, String>> storeWorkedHours(
      {required WorkedHoursModel logdata, required String docId}) {
    return _workedHourRemote.storeWorkedHours(logdata: logdata, docId: docId);
  }

  @override
  Stream<List<WorkedHoursModel>> getLogList({required String ticketDocId}) {
    return _workedHourRemote.logList(ticketDocId: ticketDocId);
  }
}
