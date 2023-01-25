import 'dart:convert';

class WorkedHoursModel {
  final String? name;
  final double workedHours;
  final String? userId;

  final String? summary;
  final DateTime? logDate;
  final DateTime? updatedAt;

  WorkedHoursModel({
    required this.name,
    required this.summary,
    required this.workedHours,
    required this.userId,
    required this.logDate,
    required this.updatedAt,
  });

  factory WorkedHoursModel.fromJson(Map<String, dynamic> json) {
    return WorkedHoursModel(
      name: json['name'],
      workedHours: json['worked_hours'],
      updatedAt: json['updated_at'].toDate(),
      userId: json['user_id'],
      logDate: json['log_date']?.toDate(),
      summary: json['summary'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'worked_hours': workedHours,
      'user_id': userId,
      'updated_at': updatedAt,
      'log_date': logDate,
      'summary': summary
    };
  }
}
