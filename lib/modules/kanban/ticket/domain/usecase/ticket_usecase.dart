import 'package:flutter_core/flutter_core.dart';
import 'package:time_tracking/modules/kanban/kanban_board/model/kanban_model.dart';
import 'package:time_tracking/modules/kanban/ticket/data/entity/worked_hour_model.dart';
import 'package:time_tracking/modules/kanban/ticket/data/entity/user_model.dart';
import 'package:time_tracking/modules/kanban/ticket/domain/repository/ticket_repository.dart';

class CreateTaskUseCase
    extends BaseUseCase<Result<String, String>, KanbanModel> {
  final TicketRepository _kanbanRepository;

  CreateTaskUseCase(this._kanbanRepository);
  @override
  Future<Result<String, String>> execute({KanbanModel? params}) {
    return _kanbanRepository.storeSingleTask(taskData: params!);
  }
}

class UpdateTicketUseCase
    extends BaseUseCase<Result<String, String>, KanbanModel> {
  final TicketRepository _ticketRepository;

  UpdateTicketUseCase(this._ticketRepository);
  @override
  Future<Result<String, String>> execute({KanbanModel? params}) {
    return _ticketRepository.updateTicket(taskData: params!);
  }
}

class GetUserDataUseCase extends BaseUseCase<Result<String, String>, void> {
  final TicketRepository _kanbanRepository;

  GetUserDataUseCase(this._kanbanRepository);
  @override
  Stream<Result<String, List<UserModel>>> call() {
    return _kanbanRepository.fetchAllUser();
  }

  @override
  Future<Result<String, String>> execute({void params}) {
    // TODO: implement execute
    throw UnimplementedError();
  }
}

class DeleteTicketUseCase extends BaseUseCase<Result<String, String>, String> {
  final TicketRepository _kanbanRepository;

  DeleteTicketUseCase(this._kanbanRepository);

  @override
  Future<Result<String, String>> execute({String? params}) {
    return _kanbanRepository.deleteTicket(docId: params!);
  }
}

class AddWorkedHoursUseCase
    extends BaseUseCase<Result<String, String>, String> {
  final TicketRepository _ticketRepository;

  AddWorkedHoursUseCase(this._ticketRepository);

  @override
  Future<Result<String, String>> execute({String? params}) {
    throw UnimplementedError();
  }

  Future<Result<String, String>> call(
      {required WorkedHoursModel logdata, required String docId}) {
    return _ticketRepository.storeWorkedHours(logdata: logdata, docId: docId);
  }
}
