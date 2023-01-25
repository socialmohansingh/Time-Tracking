import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:time_tracking/modules/kanban/ticket/data/entity/worked_hour_model.dart';
import 'package:time_tracking/modules/kanban/worked_hours/data/worked_hours_remote_data_source.dart';

class WorkedHourRemoteDataSourceImpl extends WorkedHourRemoteDataSource {
  final _firestore = FirebaseFirestore.instance.collection('task');
  @override
  Future<Result<String, String>> storeWorkedHours(
      {required WorkedHoursModel logdata, required String docId}) async {
    try {
      await _firestore.doc(docId).set({
        'total_worked_hours': FieldValue.increment(logdata.workedHours),
      }, SetOptions(merge: true));
      await _firestore
          .doc(docId)
          .collection('workedhours')
          .doc()
          .set(logdata.toJson());

      return Success('Worked Hour Added Successfully');
    } on FirebaseException catch (e) {
      return Failure('Failed With Error \n ${e.message}');
    } catch (e) {
      return Failure('Something Went Wrong');
    }
  }

  @override
  Future<Result<String, String>> deleteWorkedHours({
    required String workedHourId,
    required String docId,
  }) async {
    try {
      await _firestore
          .doc(docId)
          .collection('workedhours')
          .doc(workedHourId)
          .delete();

      return Success('Worked Hour Deleted Successfully');
    } on FirebaseException catch (e) {
      return Failure('Failed With Error \n ${e.message}');
    } catch (e) {
      return Failure('Something Went Wrong');
    }
  }

  @override
  Stream<List<WorkedHoursModel>> logList({required String ticketDocId}) {
    return _firestore
        .doc(ticketDocId)
        .collection('workedhours')
        .snapshots()
        .map((event) {
      final wHoursList = <WorkedHoursModel>[];
      for (var e in event.docs) {
        wHoursList.add(WorkedHoursModel.fromJson(e.data()));
      }

      return wHoursList;
    });
  }
}
