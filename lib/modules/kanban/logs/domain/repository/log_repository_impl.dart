import 'package:time_tracking/modules/kanban/logs/data/log_remote_data_source.dart';
import 'package:time_tracking/modules/kanban/logs/domain/repository/log_repository.dart';
import 'package:time_tracking/modules/kanban/ticket/data/entity/log_model.dart';

class LogRepositoryImpl extends LogRepository {
   final LogRemoteDataSource _logRemoteDataSource;

  LogRepositoryImpl(this._logRemoteDataSource);
  @override
  Stream<List<LogModel>> getAllLogs({required String docId}) {
    return _logRemoteDataSource.getAllLogs(docId: docId);
  }
}
