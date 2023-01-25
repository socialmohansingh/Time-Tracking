import 'package:flutter_core/flutter_core.dart';
import 'package:time_tracking/modules/kanban/kanban_board/model/kanban_model.dart';

abstract class KanbanRepository {
  
  Stream<List<KanbanModel>>fetchAllTask();

   Future<Result<String, String>> moveTicket(
      {required String column, required String docId,
      
      required String fromColumn});
}
