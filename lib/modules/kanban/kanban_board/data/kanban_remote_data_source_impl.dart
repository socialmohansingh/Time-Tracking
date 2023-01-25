import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:time_tracking/core/app_enums/log_enum.dart';
import 'package:time_tracking/modules/kanban/kanban_board/data/kanban_remote_data_source.dart';
import 'package:time_tracking/modules/kanban/kanban_board/model/kanban_model.dart';
import 'package:time_tracking/modules/kanban/ticket/data/entity/log_model.dart';

class KanbanRemoteDataSourceImpl extends KanbanRemoteDataSource {
  final _firestore = FirebaseFirestore.instance.collection('task');

  @override
  Stream<List<KanbanModel>> getAllTask() {
    try {
      return (_firestore.snapshots().map(
        (event) {
          final kanbanList = <KanbanModel>[];
          for (var e in event.docs.reversed) {
            kanbanList.add(KanbanModel.fromJson(e.data()));
          }
          return (kanbanList);
        },
      ));
    } on FirebaseException catch (e) {
      throw ('Failed With Error \n ${e.message}');
    } catch (e) {
      throw ('Something Went Wrong');
    }
  }

  @override
  Future<Result<String, String>> moveTicket(
      {required String column,
      required String docId,
      required String fromColumn}) async {
    try {
      await _firestore.doc(docId).update({
        "column": column,
        'updated_at': DateTime.now(),
      });
      await logEntry(
          docId: docId,
          logType: LogType.ticketMoved,
          message:
              'Ticket Moved to $column by ${FirebaseAuth.instance.currentUser?.displayName}');
      return Success('Moved Succesfully');
    } on FirebaseException catch (e) {
      return Failure('Failed With Error \n ${e.message}');
    } catch (e) {
      return Failure('Something Went Wrong');
    }
  }

  @override
  Future<Result<String, String>> logEntry(
      {required String docId,
      required LogType logType,
      required String message}) async {
    try {
      await _firestore.doc(docId).collection('log').doc().set(
            LogModel(
              name: FirebaseAuth.instance.currentUser?.displayName,
              logType: logType.name,
              description: message,
              userId: FirebaseAuth.instance.currentUser?.uid,
              updatedAt: DateTime.now(),
            ).toJson(),
          );

      return Success('Logged');
    } on FirebaseException catch (e) {
      return Failure('Failed With Error \n ${e.message}');
    } catch (e) {
      return Failure('Something Went Wrong');
    }
  }
}
