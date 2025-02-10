import 'package:freeorder_flutter/models/order.dart';

class Payment {
  String id;
  String ordersId;
  String paymentKey;
  String paymentMethod;
  String status;
  DateTime paidAt;
  DateTime createdAt;
  DateTime updatedAt;

  Order order;
  Payment({
    required this.id,
    required this.ordersId,
    required this.paymentKey,
    required this.paymentMethod,
    required this.status,
    required this.paidAt,
    required this.createdAt,
    required this.updatedAt,
    required this.order,
  });

  Payment copyWith({
    String? id,
    String? ordersId,
    String? paymentKey,
    String? paymentMethod,
    String? status,
    DateTime? paidAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    Order? order,
  }) {
    return Payment(
      id: id ?? this.id,
      ordersId: ordersId ?? this.ordersId,
      paymentKey: paymentKey ?? this.paymentKey,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      status: status ?? this.status,
      paidAt: paidAt ?? this.paidAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      order: order ?? this.order,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'ordersId': ordersId,
      'paymentKey': paymentKey,
      'paymentMethod': paymentMethod,
      'status': status,
      'paidAt': paidAt.millisecondsSinceEpoch,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'order': order.toMap(),
    };
  }

  factory Payment.fromMap(Map<String, dynamic> map) {
    return Payment(
      id: map['id'] as String,
      ordersId: map['ordersId'] as String,
      paymentKey: map['paymentKey'] as String,
      paymentMethod: map['paymentMethod'] as String,
      status: map['status'] as String,
      paidAt: DateTime.parse(map['paidAt']),
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
      order: Order.fromMap(map['order'] as Map<String, dynamic>),
    );
  }
}
