import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:time_tracking/modules/kanban/logs/data/log_remote_data_source.dart';
import 'package:time_tracking/modules/kanban/ticket/data/entity/log_model.dart';

class LogRemoteDataSourceImpl extends LogRemoteDataSource {
  final _firestore = FirebaseFirestore.instance.collection('task');

  @override
  Stream<List<LogModel>> getAllLogs({required String docId}) {
    try {
      return (_firestore.doc(docId).collection('log').snapshots().map(
        (event) {
          final logList = <LogModel>[];
          for (var e in event.docs.reversed) {
            logList.add(LogModel.fromJson(e.data()));
          }
          return (logList);
        },
      ));
    } on FirebaseException catch (e) {
      throw ('Failed With Error \n ${e.message}');
    } catch (e) {
      throw ('Something Went Wrong');
    }
  }
}
