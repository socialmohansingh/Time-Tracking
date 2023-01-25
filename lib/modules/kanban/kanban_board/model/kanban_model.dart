import 'dart:convert';

import 'package:time_tracking/modules/kanban/ticket/data/entity/user_model.dart';

class KanbanModel {
  final String id;
  final String name;
  final String description;
  final String assignee;
  final String type;
  final UserModel? user;
  final String hours;
  final String createdBy;

  final double? totalWorkedHours;

  final DateTime? startDate;
  final DateTime endDate;
  final DateTime createdAt;
  final DateTime? updatedAt;

  final String priority;

  final String? docId;
  String column;

  KanbanModel({
    required this.hours,
    required this.startDate,
    required this.createdBy,
    this.totalWorkedHours,
    required this.endDate,
    required this.name,
    required this.user,
    required this.id,
    required this.description,
    required this.assignee,
    required this.type,
    required this.docId,
    required this.priority,
    required this.column,
    required this.createdAt,
    required this.updatedAt,
  });

  factory KanbanModel.fromJson(Map<String, dynamic> json) => KanbanModel(
      hours: json['hours'],
      id: json['id'],
      name: json['name'],
      description: json['description'],
      totalWorkedHours: json['total_worked_hours'],
      assignee: json['assignee'],
      type: json['type'],
      docId: json['doc_id'],
      createdBy: json['created_by'],
      priority: json['priority'],
      startDate: json['start_date']?.toDate(),
      endDate: json['end_date']?.toDate(),
      updatedAt: json['updated_at']?.toDate(),
      createdAt: json['created_at']?.toDate(),
      column: json['column'],
      user: json['user'] == null ? null : UserModel.fromJson(json['user']));

  KanbanModel copyWith({
    String? hours,
    String? name,
    String? description,
    String? assignee,
    String? createdBy,
    String? type,
    String? id,
    String? priority,
    UserModel? user,
    String? column,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? createdAt,
    DateTime? updatedAt,
    double? totalWorkedHours,
    required String? docId,
  }) {
    return KanbanModel(
      id: id ?? this.id,
      totalWorkedHours: totalWorkedHours ?? this.totalWorkedHours,
      hours: hours ?? this.hours,
      name: name ?? this.name,
      description: description ?? this.description,
      assignee: assignee ?? this.assignee,
      type: type ?? this.type,
      user: user ?? this.user,
      priority: priority ?? this.priority,
      column: column ?? this.column,
      docId: docId ?? this.docId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      createdBy: createdBy ?? this.createdBy,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'assignee': assignee,
        'type': type,
        'column': column,
        'priority': priority,
        'hours': hours,
        'doc_id': docId,
        'user': user?.toJson(),
        'start_date': startDate,
        'created_at': createdAt,
        'end_date': endDate,
        'updated_at': updatedAt,
        'created_by': createdBy,
      };
}
