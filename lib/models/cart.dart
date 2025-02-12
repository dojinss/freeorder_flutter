import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:freeorder_flutter/models/cart_option.dart';

class Cart {
  String id;
  String productsId;
  String usersId;
  String optionsId;
  String productName;
  int amount;
  int price;
  DateTime createdAt;
  DateTime updatedAt;
  List<CartOption> optionList;
  Cart({
    required this.id,
    required this.productsId,
    required this.usersId,
    required this.optionsId,
    required this.productName,
    required this.amount,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    required this.optionList,
  });

  Cart copyWith({
    String? id,
    String? productsId,
    String? usersId,
    String? optionsId,
    String? productName,
    int? amount,
    int? price,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<CartOption>? optionList,
  }) {
    return Cart(
      id: id ?? this.id,
      productsId: productsId ?? this.productsId,
      usersId: usersId ?? this.usersId,
      optionsId: optionsId ?? this.optionsId,
      productName: productName ?? this.productName,
      amount: amount ?? this.amount,
      price: price ?? this.price,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      optionList: optionList ?? this.optionList,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'productsId': productsId,
      'usersId': usersId,
      'optionsId': optionsId,
      'productName': productName,
      'amount': amount,
      'price': price,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
      'optionList': optionList.map((x) => x.toMap()).toList(),
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      id: map['id'] as String? ?? '', // null일 경우 빈 문자열로 대체
      productsId: map['productsId'] as String? ?? '',
      usersId: map['usersId'] as String? ?? '',
      optionsId: map['optionsId'] as String? ?? '',
      productName: map['productName'] as String? ?? '',
      amount: map['amount'] as int? ?? 0, // 기본값 0 설정
      price: map['price'] as int? ?? 0, // 기본값 0 설정
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int? ?? 0),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int? ?? 0),
      optionList: List<CartOption>.from(
        (map['optionList'] as List<dynamic>? ?? []).map<CartOption>(
          (x) => CartOption.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Cart.fromJson(String source) => Cart.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Cart(id: $id, productsId: $productsId, usersId: $usersId, optionsId: $optionsId, productName: $productName, amount: $amount, price: $price, createdAt: $createdAt, updatedAt: $updatedAt, optionList: $optionList)';
  }

  @override
  bool operator ==(covariant Cart other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.id == id &&
        other.productsId == productsId &&
        other.usersId == usersId &&
        other.optionsId == optionsId &&
        other.productName == productName &&
        other.amount == amount &&
        other.price == price &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        listEquals(other.optionList, optionList);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        productsId.hashCode ^
        usersId.hashCode ^
        optionsId.hashCode ^
        productName.hashCode ^
        amount.hashCode ^
        price.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        optionList.hashCode;
  }
}
