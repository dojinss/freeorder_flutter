import 'dart:convert';

class OptionItem {
  final String id;
  final String optionsId;
  final String name;
  final int quantity;
  final int price;
  final int seq;
  final DateTime createdAt;
  final DateTime updatedAt;
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
    this.checked = false, // 기본값 false
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
      checked: checked ?? this.checked, // null이면 기존 값 유지
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'optionsId': optionsId,
      'name': name,
      'quantity': quantity,
      'price': price,
      'seq': seq,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'checked': checked,
    };
  }

  factory OptionItem.fromMap(Map<String, dynamic> map) {
    return OptionItem(
      id: map['id'] ?? '',
      optionsId: map['optionsId'] ?? '',
      name: map['name'] ?? '',
      quantity: map['quantity'] ?? 0,
      price: map['price'] ?? 0,
      seq: map['seq'] ?? 0,
      createdAt: DateTime.tryParse(map['createdAt'].toString()) ?? DateTime.now(),
      updatedAt: DateTime.tryParse(map['updatedAt'].toString()) ?? DateTime.now(),
      checked: map['checked'] == true, // `null` 또는 `false`일 경우 `false` 유지
    );
  }

  String toJson() => json.encode(toMap());

  factory OptionItem.fromJson(String source) => OptionItem.fromMap(json.decode(source));

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
