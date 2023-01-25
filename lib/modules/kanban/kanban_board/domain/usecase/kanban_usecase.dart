import 'dart:collection';

import 'package:flutter_core/flutter_core.dart';
import 'package:time_tracking/modules/kanban/kanban_board/domain/repository/kanban_repository.dart';
import 'package:time_tracking/modules/kanban/kanban_board/model/kanban_model.dart';
import 'package:time_tracking/modules/kanban/kanban_board/model/move_model.dart';

class FetchAllTaskUseCase
    extends BaseUseCase<Result<String, Stream<List<KanbanModel>>>, void> {
  final KanbanRepository _kanbanRepository;

  FetchAllTaskUseCase(this._kanbanRepository);

  @override
  Future<Result<String, Stream<List<KanbanModel>>>> execute({void params}) {
    // TODO: implement execute
    throw UnimplementedError();
  }

  Stream<LinkedHashMap<String, List<KanbanModel>>> call() {
    return _kanbanRepository.fetchAllTask().map((event) {
      final LinkedHashMap<String, List<KanbanModel>> board = LinkedHashMap();
      board.addAll({
        "TODO": event.where((element) => element.column == 'TODO').toList(),
        "Inprogress":
            event.where((element) => element.column == 'Inprogress').toList(),
        "Done": event.where((element) => element.column == 'Done').toList()
      });
      return board;
    });
  }
}

class MoveTicketUsecase extends BaseUseCase<Result<String, String>, MoveModel> {
  final KanbanRepository _kanbanRepository;

  MoveTicketUsecase(this._kanbanRepository);
  @override
  Future<Result<String, String>> execute({MoveModel? params}) {
    return _kanbanRepository.moveTicket(
        column: params!.column, docId: params.docId,
        fromColumn: params.column
        );
  }
}
