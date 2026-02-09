import 'package:uuid/uuid.dart';

enum ProfileRole { admin, operator, viewer }

class ProfileModel {
  final String id;
  final String? fullName;
  final ProfileRole role;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProfileModel({
    required this.id,
    this.fullName,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'full_name': fullName,
      'role': role.name,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      id: map['id'],
      fullName: map['full_name'],
      role: ProfileRole.values.firstWhere(
        (e) => e.name == map['role'],
        orElse: () => ProfileRole.viewer,
      ),
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }
}
