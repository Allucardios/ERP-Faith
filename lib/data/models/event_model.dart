import 'package:uuid/uuid.dart';

class EventModel {
  final String id;
  final String title;
  final String? description;
  final String eventType;
  final DateTime startAt;
  final DateTime? endAt;
  final String? location;
  final int? expectedAttendance;
  final double cost;
  final DateTime createdAt;
  final DateTime updatedAt;

  EventModel({
    required this.id,
    required this.title,
    this.description,
    required this.eventType,
    required this.startAt,
    this.endAt,
    this.location,
    this.expectedAttendance,
    this.cost = 0,
    required this.createdAt,
    required this.updatedAt,
  });

  factory EventModel.createNew({
    required String title,
    required String eventType,
    required DateTime startAt,
    String? description,
    String? location,
    int? expectedAttendance,
  }) {
    final now = DateTime.now();
    return EventModel(
      id: const Uuid().v4(),
      title: title,
      eventType: eventType,
      startAt: startAt,
      description: description,
      location: location,
      expectedAttendance: expectedAttendance,
      createdAt: now,
      updatedAt: now,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'event_type': eventType,
      'start_at': startAt.toIso8601String(),
      'end_at': endAt?.toIso8601String(),
      'location': location,
      'expected_attendance': expectedAttendance,
      'cost': cost,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      eventType: map['event_type'],
      startAt: DateTime.parse(map['start_at']),
      endAt: map['end_at'] != null ? DateTime.parse(map['end_at']) : null,
      location: map['location'],
      expectedAttendance: map['expected_attendance'],
      cost: (map['cost'] as num).toDouble(),
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }
}
