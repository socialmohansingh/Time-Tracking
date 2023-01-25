import 'package:flutter_core/flutter_core.dart';
import 'package:time_tracking/modules/kanban/kanban_board/model/kanban_model.dart';
import 'package:time_tracking/modules/kanban/ticket/data/entity/worked_hour_model.dart';
import 'package:time_tracking/modules/kanban/ticket/data/entity/user_model.dart';
import 'package:time_tracking/modules/kanban/ticket/domain/repository/ticket_repository.dart';

import '../../data/ticket_remote_data_source.dart';

class TicketRepositoryImpl extends TicketRepository {
  final TicketRemoteDataSource _remoteDataSource;

  TicketRepositoryImpl(this._remoteDataSource);
  @override
  Future<Result<String, String>> storeSingleTask(
      {required KanbanModel taskData}) {
    return _remoteDataSource.createSingleTask(taskData: taskData);
  }

  @override
  Stream<Result<String, List<UserModel>>> fetchAllUser() {
    return _remoteDataSource.getAllUser();
  }

  @override
  Future<Result<String, String>> updateTicket({required KanbanModel taskData}) {
    return _remoteDataSource.updateTicket(taskData: taskData);
  }

  @override
  Future<Result<String, String>> deleteTicket({required String docId}) {
    return _remoteDataSource.deleteTicket(docId: docId);
  }

  @override
  Future<Result<String, String>> storeWorkedHours(
      {required WorkedHoursModel logdata, required String docId}) {
    return _remoteDataSource.storeWorkedHours(workdata: logdata, docId: docId);
  }
}
