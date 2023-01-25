import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:time_tracking/core/app_enums/log_enum.dart';
import 'package:time_tracking/modules/kanban/kanban_board/model/kanban_model.dart';
import 'package:time_tracking/modules/kanban/ticket/data/entity/log_model.dart';
import 'package:time_tracking/modules/kanban/ticket/data/entity/worked_hour_model.dart';
import 'package:time_tracking/modules/kanban/ticket/data/entity/user_model.dart';
import 'package:time_tracking/modules/kanban/ticket/data/ticket_remote_data_source.dart';

class TicketRemoteDataSourceImpl extends TicketRemoteDataSource {
  final _firestore = FirebaseFirestore.instance.collection('task');
  final _firestoreUser = FirebaseFirestore.instance.collection('user');

  @override
  Future<Result<String, String>> createSingleTask(
      {required KanbanModel taskData}) async {
    try {
      final doc = _firestore.doc();

      await doc.set(taskData.copyWith(docId: doc.id).toJson());
      logEntry(
          docId: doc.id,
          logType: LogType.created,
          message:
              'Ticket created by ${FirebaseAuth.instance.currentUser?.displayName}');
      return Success('Task Successfully Stored');
    } on FirebaseException catch (e) {
      return Failure('Failed With Error \n ${e.message}');
    } catch (e) {
      return Failure('Something Went Wrong');
    }
  }

  @override
  Stream<Result<String, List<UserModel>>> getAllUser() {
    try {
      return _firestoreUser.snapshots().map((event) {
        final userList = <UserModel>[];
        for (var e in event.docs) {
          userList.add(UserModel.fromJson(e.data()));
        }
        return Success(userList);
      });
    } on FirebaseException catch (e) {
      throw Failure('Failed With Error \n ${e.message}');
    } catch (e) {
      throw Failure('Something Went Wrong');
    }
  }

  @override
  Future<Result<String, String>> updateTicket(
      {required KanbanModel taskData}) async {
    try {
      final doc = _firestore.doc('${taskData.docId}');

      await doc.update(taskData.toJson());
      await logEntry(
          docId: '${taskData.docId}',
          logType: LogType.updated,
          message:
              'Ticket Updated by ${FirebaseAuth.instance.currentUser?.displayName} ');

      return Success('Task Successfully Stored');
    } on FirebaseException catch (e) {
      return Failure('Failed With Error \n ${e.message}');
    } catch (e) {
      return Failure('Something Went Wrong');
    }
  }

  @override
  Future<Result<String, String>> deleteTicket({required String docId}) async {
    try {
      await _firestore.doc(docId).delete();

      return Success('Ticket Deleted Successfully');
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
              ticketId: docId,
              description: 'Ticket  ${logType.name}',
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

  @override
  Future<Result<String, String>> storeWorkedHours(
      {required WorkedHoursModel workdata, required String docId}) async {
    try {
      await _firestore.doc(docId).collection('workedhours').doc().set(
            workdata.toJson(),
          );

      logEntry(
          docId: docId,
          logType: LogType.addedWorkedHours,
          message:
              '${LogType.addedWorkedHours} hours Work logged by ${FirebaseAuth.instance.currentUser?.displayName}');

      return Success('Worked Hour Added Successfully');
    } on FirebaseException catch (e) {
      return Failure('Failed With Error \n ${e.message}');
    } catch (e) {
      return Failure('Something Went Wrong');
    }
  }
}
