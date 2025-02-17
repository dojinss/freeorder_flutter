import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:freeorder_flutter/models/order_option.dart';

class OrderItem {
  String id;
  String ordersId;
  String productsId;
  String optionsId;
  String name;
  int quantity;
  int price;
  int amount;
  DateTime createdAt;
  DateTime updatedAt;
  List<OrderOption> optionList;
  OrderItem({
    required this.id,
    required this.ordersId,
    required this.productsId,
    required this.optionsId,
    required this.name,
    required this.quantity,
    required this.price,
    required this.amount,
    required this.createdAt,
    required this.updatedAt,
    required this.optionList,
  });

  OrderItem copyWith({
    String? id,
    String? ordersId,
    String? productsId,
    String? optionsId,
    String? name,
    int? quantity,
    int? price,
    int? amount,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<OrderOption>? optionList,
  }) {
    return OrderItem(
      id: id ?? this.id,
      ordersId: ordersId ?? this.ordersId,
      productsId: productsId ?? this.productsId,
      optionsId: optionsId ?? this.optionsId,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      amount: amount ?? this.amount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      optionList: optionList ?? this.optionList,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'ordersId': ordersId,
      'productsId': productsId,
      'optionsId': optionsId,
      'name': name,
      'quantity': quantity,
      'price': price,
      'amount': amount,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'optionList': optionList.map((x) => x.toMap()).toList(),
    };
  }

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      id: (map['id'] as String?) ?? '',
      ordersId: (map['ordersId'] as String?) ?? '',
      productsId: (map['productsId'] as String?) ?? '',
      optionsId: (map['optionsId'] as String?) ?? '',
      name: (map['name'] as String?) ?? '',
      quantity: (map['quantity'] as int?) ?? 0,
      price: (map['price'] as int?) ?? 0,
      amount: (map['amount'] as int?) ?? 0,
      createdAt: (map['createdAt'] ?? DateTime.now()) is int
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] ?? 0)
          : (map['createdAt'] != null ? DateTime.parse(map['createdAt']) : DateTime.now()),
      updatedAt: map['updatedAt'] is int
          ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] ?? 0)
          : (map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : DateTime.now()),
      optionList: List<OrderOption>.from(
        (map['optionList']).map<OrderOption>(
          (x) => OrderOption.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderItem.fromJson(String source) => OrderItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderItem(id: $id, ordersId: $ordersId, productsId: $productsId, optionsId: $optionsId, name: $name, quantity: $quantity, price: $price, amount: $amount, createdAt: $createdAt, updatedAt: $updatedAt, optionList: $optionList)';
  }

  @override
  bool operator ==(covariant OrderItem other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.id == id &&
        other.ordersId == ordersId &&
        other.productsId == productsId &&
        other.optionsId == optionsId &&
        other.name == name &&
        other.quantity == quantity &&
        other.price == price &&
        other.amount == amount &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        listEquals(other.optionList, optionList);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        ordersId.hashCode ^
        productsId.hashCode ^
        optionsId.hashCode ^
        name.hashCode ^
        quantity.hashCode ^
        price.hashCode ^
        amount.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        optionList.hashCode;
  }
}
