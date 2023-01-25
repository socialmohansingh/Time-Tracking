import 'package:time_tracking/modules/kanban/ticket/data/entity/log_model.dart';

abstract class LogRepository{
  Stream<List<LogModel>> getAllLogs({required String docId});
}