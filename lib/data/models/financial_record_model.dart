import 'package:uuid/uuid.dart';

enum RecordType { income, expense }

enum PaymentMethod { cash, bankTransfer, multicaixa, other }

class FinancialRecordModel {
  final String id;
  final String description;
  final double amount;
  final RecordType type;
  final String category;
  final DateTime recordDate;
  final String? memberId;
  final PaymentMethod? paymentMethod;
  final String? referenceEventId;
  final String? recordedBy;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  FinancialRecordModel({
    required this.id,
    required this.description,
    required this.amount,
    required this.type,
    required this.category,
    required this.recordDate,
    this.memberId,
    this.paymentMethod,
    this.referenceEventId,
    this.recordedBy,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'amount': amount,
      'type': type.name,
      'category': category,
      'record_date': recordDate.toIso8601String().split('T')[0],
      'member_id': memberId,
      'payment_method': paymentMethod?.name,
      'reference_event_id': referenceEventId,
      'recorded_by': recordedBy,
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory FinancialRecordModel.fromMap(Map<String, dynamic> map) {
    return FinancialRecordModel(
      id: map['id'],
      description: map['description'],
      amount: (map['amount'] as num).toDouble(),
      type: map['type'] == 'income' ? RecordType.income : RecordType.expense,
      category: map['category'],
      recordDate: DateTime.parse(map['record_date']),
      memberId: map['member_id'],
      paymentMethod: map['payment_method'] != null
          ? PaymentMethod.values.firstWhere(
              (e) => e.name == map['payment_method'],
              orElse: () => PaymentMethod.other,
            )
          : null,
      referenceEventId: map['reference_event_id'],
      recordedBy: map['recorded_by'],
      notes: map['notes'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }
}
