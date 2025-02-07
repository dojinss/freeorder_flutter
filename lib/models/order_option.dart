import 'dart:convert';

class OrderOption {
  String id;
  String optionItemsId;
  String orderItemsId;
  String name;
  int price;
  DateTime createdAt;
  DateTime updatedAt;
  OrderOption({
    required this.id,
    required this.optionItemsId,
    required this.orderItemsId,
    required this.name,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
  });

  OrderOption copyWith({
    String? id,
    String? optionItemsId,
    String? orderItemsId,
    String? name,
    int? price,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return OrderOption(
      id: id ?? this.id,
      optionItemsId: optionItemsId ?? this.optionItemsId,
      orderItemsId: orderItemsId ?? this.orderItemsId,
      name: name ?? this.name,
      price: price ?? this.price,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'optionItemsId': optionItemsId,
      'orderItemsId': orderItemsId,
      'name': name,
      'price': price,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory OrderOption.fromMap(Map<String, dynamic> map) {
    return OrderOption(
      id: map['id'] as String,
      optionItemsId: map['optionItemsId'] as String,
      orderItemsId: map['orderItemsId'] as String,
      name: map['name'] as String,
      price: map['price'] as int,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderOption.fromJson(String source) => OrderOption.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderOption(id: $id, optionItemsId: $optionItemsId, orderItemsId: $orderItemsId, name: $name, price: $price, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant OrderOption other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.optionItemsId == optionItemsId &&
        other.orderItemsId == orderItemsId &&
        other.name == name &&
        other.price == price &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        optionItemsId.hashCode ^
        orderItemsId.hashCode ^
        name.hashCode ^
        price.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
