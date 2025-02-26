import '../../domain/entities/user.dart';

/// Data layer model that can be serialized/deserialized to/from JSON.
/// Also extends the domain entity [User].
class UserModel extends User {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.token,
  });

  /// Convert JSON to a [UserModel].
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '--', // good practice to use `--` for no data
      email: json['email'] ?? '--',
      token: json['token'] ?? '',
    );
  }

  /// Convert a [UserModel] to JSON.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'token': token,
    };
  }
}
