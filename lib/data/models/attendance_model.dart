import 'package:uuid/uuid.dart';

class AttendanceModel {
  final String id;
  final String eventId;
  final String memberId;
  final bool isPresent;
  final DateTime checkInAt;

  AttendanceModel({
    required this.id,
    required this.eventId,
    required this.memberId,
    this.isPresent = true,
    required this.checkInAt,
  });

  factory AttendanceModel.createNew({
    required String eventId,
    required String memberId,
    bool isPresent = true,
  }) {
    return AttendanceModel(
      id: const Uuid().v4(),
      eventId: eventId,
      memberId: memberId,
      isPresent: isPresent,
      checkInAt: DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'event_id': eventId,
      'member_id': memberId,
      'is_present': isPresent,
      'check_in_at': checkInAt.toIso8601String(),
    };
  }

  factory AttendanceModel.fromMap(Map<String, dynamic> map) {
    return AttendanceModel(
      id: map['id'],
      eventId: map['event_id'],
      memberId: map['member_id'],
      isPresent: map['is_present'] ?? true,
      checkInAt: DateTime.parse(map['check_in_at']),
    );
  }
}
