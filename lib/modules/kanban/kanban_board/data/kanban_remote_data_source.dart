import 'package:flutter_core/flutter_core.dart';
import 'package:time_tracking/core/app_enums/log_enum.dart';
import 'package:time_tracking/modules/kanban/kanban_board/model/kanban_model.dart';

abstract class KanbanRemoteDataSource {
  Stream<List<KanbanModel>> getAllTask();
  Future<Result<String, String>> moveTicket(
      {required String column,
      required String docId,
      required String fromColumn});

  Future<Result<String, String>> logEntry(
      {required String docId,
      required LogType logType,
      required String message});
}
