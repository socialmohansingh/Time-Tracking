import 'package:flutter_core/flutter_core.dart';
import 'package:time_tracking/modules/kanban/kanban_board/model/kanban_model.dart';
import 'package:time_tracking/modules/kanban/ticket/data/entity/worked_hour_model.dart';
import 'package:time_tracking/modules/kanban/ticket/data/entity/user_model.dart';

import '../../../../core/app_enums/log_enum.dart';

abstract class TicketRemoteDataSource {
  Future<Result<String, String>> createSingleTask(
      {required KanbanModel taskData});
  Future<Result<String, String>> updateTicket({required KanbanModel taskData});

  Future<Result<String, String>> deleteTicket({required String docId});
  Future<Result<String, String>> logEntry(
      {required String docId, required LogType logType,required  String message});
  Stream<Result<String, List<UserModel>>> getAllUser();

  Future<Result<String, String>> storeWorkedHours(
      {required WorkedHoursModel workdata, required String docId});
}
