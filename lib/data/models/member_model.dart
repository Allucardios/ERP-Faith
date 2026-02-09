import 'package:uuid/uuid.dart';

enum MemberStatus { active, absent, transferred, deceased }

enum Gender { m, f }

class MemberModel {
  final String id;
  final String fullName;
  final String? photoUrl;
  final String? phone;
  final String? email;
  final DateTime? birthDate;
  final Gender? gender;
  final String? address;
  final DateTime entryDate;
  final MemberStatus status;
  final String? ministry;
  final String? groupName;
  final String? position;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  MemberModel({
    required this.id,
    required this.fullName,
    this.photoUrl,
    this.phone,
    this.email,
    this.birthDate,
    this.gender,
    this.address,
    required this.entryDate,
    required this.status,
    this.ministry,
    this.groupName,
    this.position,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MemberModel.createNew({
    required String fullName,
    String? phone,
    String? ministry,
    String? groupName,
    String? position,
  }) {
    final now = DateTime.now();
    return MemberModel(
      id: const Uuid().v4(),
      fullName: fullName,
      phone: phone,
      entryDate: now,
      status: MemberStatus.active,
      ministry: ministry,
      groupName: groupName,
      position: position,
      createdAt: now,
      updatedAt: now,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'full_name': fullName,
      'photo_url': photoUrl,
      'phone': phone,
      'email': email,
      'birth_date': birthDate?.toIso8601String(),
      'gender': gender?.name.toUpperCase(),
      'address': address,
      'entry_date': entryDate.toIso8601String(),
      'status': status.name,
      'ministry': ministry,
      'group_name': groupName,
      'position': position,
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory MemberModel.fromMap(Map<String, dynamic> map) {
    return MemberModel(
      id: map['id'],
      fullName: map['full_name'],
      photoUrl: map['photo_url'],
      phone: map['phone'],
      email: map['email'],
      birthDate: map['birth_date'] != null
          ? DateTime.parse(map['birth_date'])
          : null,
      gender: map['gender'] == 'M'
          ? Gender.m
          : (map['gender'] == 'F' ? Gender.f : null),
      address: map['address'],
      entryDate: DateTime.parse(map['entry_date']),
      status: MemberStatus.values.firstWhere(
        (e) => e.name == map['status'],
        orElse: () => MemberStatus.active,
      ),
      ministry: map['ministry'],
      groupName: map['group_name'],
      position: map['position'],
      notes: map['notes'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }
}
