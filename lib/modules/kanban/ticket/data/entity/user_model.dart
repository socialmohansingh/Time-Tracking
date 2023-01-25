class UserModel {
  final String? name;
  final String? id;
  final String? email;

  UserModel({
    required this.name,
    required this.id,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      id: json['id'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name':name,
      'id':id,
      'email':email,
    };
  }
}
