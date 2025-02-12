import 'dart:convert';

class CartOption {
  String id;
  String cartsId;
  String usersId;
  String optionItemsId;
  String name;
  int price;
  DateTime createdAt;
  DateTime updatedAt;
  CartOption({
    required this.id,
    required this.cartsId,
    required this.usersId,
    required this.optionItemsId,
    required this.name,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
  });

  CartOption copyWith({
    String? id,
    String? cartsId,
    String? usersId,
    String? optionItemsId,
    String? name,
    int? price,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CartOption(
      id: id ?? this.id,
      cartsId: cartsId ?? this.cartsId,
      usersId: usersId ?? this.usersId,
      optionItemsId: optionItemsId ?? this.optionItemsId,
      name: name ?? this.name,
      price: price ?? this.price,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'cartsId': cartsId,
      'usersId': usersId,
      'optionItemsId': optionItemsId,
      'name': name,
      'price': price,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory CartOption.fromMap(Map<String, dynamic> map) {
    return CartOption(
      id: map['id'] as String? ?? '',
      cartsId: map['cartsId'] as String? ?? '',
      usersId: map['usersId'] as String? ?? '',
      optionItemsId: map['optionItemsId'] as String? ?? '',
      name: map['name'] as String? ?? '',
      price: map['price'] is String
          ? int.tryParse(map['price'] as String) ?? 0 // String을 int로 안전하게 변환
          : map['price'] as int? ?? 0, // 이미 int일 경우 그대로 사용
      createdAt:
          map['createdAt'] != null && map['createdAt'] is int ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int) : DateTime.now(),
      updatedAt:
          map['updatedAt'] != null && map['updatedAt'] is int ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int) : DateTime.now(),
    );
  }

  String toJson() => json.encode(toMap());

  factory CartOption.fromJson(String source) => CartOption.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CartOption(id: $id, cartsId: $cartsId, usersId: $usersId, optionItemsId: $optionItemsId, name: $name, price: $price, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant CartOption other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.cartsId == cartsId &&
        other.usersId == usersId &&
        other.optionItemsId == optionItemsId &&
        other.name == name &&
        other.price == price &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        cartsId.hashCode ^
        usersId.hashCode ^
        optionItemsId.hashCode ^
        name.hashCode ^
        price.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
