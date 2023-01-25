import 'package:flutter_core/flutter_core.dart';
import 'package:time_tracking/modules/kanban/ticket/data/entity/worked_hour_model.dart';

abstract class WorkedHourRepository {
  Future<Result<String, String>> storeWorkedHours(
      {required WorkedHoursModel logdata, required String docId});
  Future<Result<String, String>> deleteWorkedHours({
    required String workedHourId,
    required String docId,
  });

  Stream<List<WorkedHoursModel>> getLogList({required String ticketDocId});
}
