import 'package:flutter_core/src/utils/result.dart';
import 'package:time_tracking/modules/kanban/kanban_board/data/kanban_remote_data_source.dart';
import 'package:time_tracking/modules/kanban/kanban_board/domain/repository/kanban_repository.dart';
import 'package:time_tracking/modules/kanban/kanban_board/model/kanban_model.dart';

class KanbanRepositoryImpl extends KanbanRepository {
  final KanbanRemoteDataSource _remoteDataSource;

  KanbanRepositoryImpl(this._remoteDataSource);

  @override
  Stream<List<KanbanModel>> fetchAllTask() {
    return _remoteDataSource.getAllTask();
  }

  @override
  Future<Result<String, String>> moveTicket(
      {required String column, required String docId,
      
      required String fromColumn}) {
    return _remoteDataSource.moveTicket(column: column, docId: docId,fromColumn: fromColumn);
  }
}
