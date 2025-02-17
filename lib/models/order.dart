import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:freeorder_flutter/models/order_item.dart';

class Order {
  String id;
  int orderNumber;
  String type;
  String usersId;
  String title;
  int totalQuantity;
  int totalCount;
  int totalPrice;
  String status;
  DateTime orderedAt;
  DateTime createdAt;
  DateTime updatedAt;
  List<OrderItem> itemList;
  Order({
    required this.id,
    required this.orderNumber,
    required this.type,
    required this.usersId,
    required this.title,
    required this.totalQuantity,
    required this.totalCount,
    required this.totalPrice,
    required this.status,
    required this.orderedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.itemList,
  });

  Order copyWith({
    String? id,
    int? orderNumber,
    String? type,
    String? usersId,
    String? title,
    int? totalQuantity,
    int? totalCount,
    int? totalPrice,
    String? status,
    DateTime? orderedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<OrderItem>? itemList,
  }) {
    return Order(
      id: id ?? this.id,
      orderNumber: orderNumber ?? this.orderNumber,
      type: type ?? this.type,
      usersId: usersId ?? this.usersId,
      title: title ?? this.title,
      totalQuantity: totalQuantity ?? this.totalQuantity,
      totalCount: totalCount ?? this.totalCount,
      totalPrice: totalPrice ?? this.totalPrice,
      status: status ?? this.status,
      orderedAt: orderedAt ?? this.orderedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      itemList: itemList ?? this.itemList,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'orderNumber': orderNumber,
      'type': type,
      'usersId': usersId,
      'title': title,
      'totalQuantity': totalQuantity,
      'totalCount': totalCount,
      'totalPrice': totalPrice,
      'status': status,
      'orderedAt': orderedAt.millisecondsSinceEpoch,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
      'itemList': itemList.map((x) => x.toMap()).toList(),
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'] as String,
      orderNumber: map['orderNumber'] as int,
      type: map['type'] as String,
      usersId: map['usersId'] as String,
      title: map['title'] as String,
      totalQuantity: map['totalQuantity'] as int,
      totalCount: map['totalCount'] as int,
      totalPrice: map['totalPrice'] as int,
      status: map['status'] as String,
      orderedAt: map['orderedAt'] is int ? DateTime.fromMillisecondsSinceEpoch(map['orderedAt']) : DateTime.parse(map['orderedAt']),
      createdAt: map['createdAt'] is int ? DateTime.fromMillisecondsSinceEpoch(map['createdAt']) : DateTime.parse(map['createdAt']),
      updatedAt: map['updatedAt'] is int ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt']) : DateTime.parse(map['updatedAt']),
      itemList: List<OrderItem>.from(
        (map['itemList']).map<OrderItem>(
          (x) => OrderItem.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Order(id: $id, orderNumber: $orderNumber, type: $type, usersId: $usersId, title: $title, totalQuantity: $totalQuantity, totalCount: $totalCount, totalPrice: $totalPrice, status: $status, orderedAt: $orderedAt, createdAt: $createdAt, updatedAt: $updatedAt, itemList: $itemList)';
  }

  @override
  bool operator ==(covariant Order other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.id == id &&
        other.orderNumber == orderNumber &&
        other.type == type &&
        other.usersId == usersId &&
        other.title == title &&
        other.totalQuantity == totalQuantity &&
        other.totalCount == totalCount &&
        other.totalPrice == totalPrice &&
        other.status == status &&
        other.orderedAt == orderedAt &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        listEquals(other.itemList, itemList);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        orderNumber.hashCode ^
        type.hashCode ^
        usersId.hashCode ^
        title.hashCode ^
        totalQuantity.hashCode ^
        totalCount.hashCode ^
        totalPrice.hashCode ^
        status.hashCode ^
        orderedAt.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        itemList.hashCode;
  }
}
