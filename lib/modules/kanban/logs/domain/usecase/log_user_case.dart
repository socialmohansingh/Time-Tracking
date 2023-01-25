import 'package:flutter_core/flutter_core.dart';
import 'package:time_tracking/modules/kanban/logs/domain/repository/log_repository.dart';
import 'package:time_tracking/modules/kanban/ticket/data/entity/log_model.dart';

class LogUseCase extends BaseUseCase<void, void> {
  final LogRepository _logRepository;

  LogUseCase(this._logRepository);
  @override
  Future<void> execute({void params}) {
    // TODO: implement execute
    throw UnimplementedError();
  }

  Stream<List<LogModel>> call({required String docId}) {
    return _logRepository.getAllLogs(docId: docId);
  }
}
