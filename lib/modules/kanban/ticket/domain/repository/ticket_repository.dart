import 'package:flutter_core/flutter_core.dart';
import 'package:time_tracking/modules/kanban/kanban_board/model/kanban_model.dart';
import 'package:time_tracking/modules/kanban/ticket/data/entity/worked_hour_model.dart';
import 'package:time_tracking/modules/kanban/ticket/data/entity/user_model.dart';

abstract class TicketRepository {
  Future<Result<String, String>> storeSingleTask(
      {required KanbanModel taskData});
  Stream<Result<String, List<UserModel>>> fetchAllUser();

  Future<Result<String, String>> updateTicket({required KanbanModel taskData});

  Future<Result<String, String>> deleteTicket({required String docId});

  Future<Result<String, String>> storeWorkedHours(
      {required WorkedHoursModel logdata, required String docId});
}
