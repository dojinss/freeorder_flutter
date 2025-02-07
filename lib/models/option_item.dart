import 'dart:convert';

class OptionItem {
  String id;
  String optionsId;
  String name;
  int quantity;
  int price;
  int seq;
  DateTime createdAt;
  DateTime updatedAt;
  bool checked;
  OptionItem({
    required this.id,
    required this.optionsId,
    required this.name,
    required this.quantity,
    required this.price,
    required this.seq,
    required this.createdAt,
    required this.updatedAt,
    required this.checked,
  });

  OptionItem copyWith({
    String? id,
    String? optionsId,
    String? name,
    int? quantity,
    int? price,
    int? seq,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? checked,
  }) {
    return OptionItem(
      id: id ?? this.id,
      optionsId: optionsId ?? this.optionsId,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      seq: seq ?? this.seq,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      checked: checked ?? this.checked,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'optionsId': optionsId,
      'name': name,
      'quantity': quantity,
      'price': price,
      'seq': seq,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
      'checked': checked,
    };
  }

  factory OptionItem.fromMap(Map<String, dynamic> map) {
    return OptionItem(
      id: map['id'] as String,
      optionsId: map['optionsId'] as String,
      name: map['name'] as String,
      quantity: map['quantity'] as int,
      price: map['price'] as int,
      seq: map['seq'] as int,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
      checked: map['checked'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory OptionItem.fromJson(String source) => OptionItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OptionItem(id: $id, optionsId: $optionsId, name: $name, quantity: $quantity, price: $price, seq: $seq, createdAt: $createdAt, updatedAt: $updatedAt, checked: $checked)';
  }

  @override
  bool operator ==(covariant OptionItem other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.optionsId == optionsId &&
        other.name == name &&
        other.quantity == quantity &&
        other.price == price &&
        other.seq == seq &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.checked == checked;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        optionsId.hashCode ^
        name.hashCode ^
        quantity.hashCode ^
        price.hashCode ^
        seq.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        checked.hashCode;
  }
}
