class LogModel {
  final String? name;
  final String? logType;
  final String? description;
  final String? ticketId;
  final String? userId;
  final DateTime? updatedAt;

  LogModel({
    required this.name,
    required this.logType,
    required this.userId,
    this.description,
    this.ticketId,
    required this.updatedAt,
  });

  factory LogModel.fromJson(Map<String, dynamic> json) {
    return LogModel(
      name: json['name'],
      logType: json['log_type'],
      description: json['description'],
      updatedAt: json['updated_at']?.toDate(),
      userId: json['user_id'],
      ticketId: json['ticket_id'],

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'log_type': logType,
      'user_id': userId,
      'updated_at': updatedAt,
      'description': description,
      'ticket_id':ticketId,
    };
  }
}
