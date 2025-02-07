import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:freeorder_flutter/models/option_item.dart';

class Option {
  String id;
  String name;
  bool stockCheck;
  int stock;
  bool essential;
  int selectMin;
  int selectMax;
  DateTime createdAt;
  DateTime updatedAt;
  List<OptionItem> itemList;
  Option({
    required this.id,
    required this.name,
    required this.stockCheck,
    required this.stock,
    required this.essential,
    required this.selectMin,
    required this.selectMax,
    required this.createdAt,
    required this.updatedAt,
    required this.itemList,
  });

  Option copyWith({
    String? id,
    String? name,
    bool? stockCheck,
    int? stock,
    bool? essential,
    int? selectMin,
    int? selectMax,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<OptionItem>? itemList,
  }) {
    return Option(
      id: id ?? this.id,
      name: name ?? this.name,
      stockCheck: stockCheck ?? this.stockCheck,
      stock: stock ?? this.stock,
      essential: essential ?? this.essential,
      selectMin: selectMin ?? this.selectMin,
      selectMax: selectMax ?? this.selectMax,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      itemList: itemList ?? this.itemList,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'stockCheck': stockCheck,
      'stock': stock,
      'essential': essential,
      'selectMin': selectMin,
      'selectMax': selectMax,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
      'itemList': itemList.map((x) => x.toMap()).toList(),
    };
  }

  factory Option.fromMap(Map<String, dynamic> map) {
    return Option(
      id: map['id'] as String,
      name: map['name'] as String,
      stockCheck: map['stockCheck'] as bool,
      stock: map['stock'] as int,
      essential: map['essential'] as bool,
      selectMin: map['selectMin'] as int,
      selectMax: map['selectMax'] as int,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
      itemList: List<OptionItem>.from(
        (map['itemList'] as List<int>).map<OptionItem>(
          (x) => OptionItem.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Option.fromJson(String source) => Option.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Option(id: $id, name: $name, stockCheck: $stockCheck, stock: $stock, essential: $essential, selectMin: $selectMin, selectMax: $selectMax, createdAt: $createdAt, updatedAt: $updatedAt, itemList: $itemList)';
  }

  @override
  bool operator ==(covariant Option other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.id == id &&
        other.name == name &&
        other.stockCheck == stockCheck &&
        other.stock == stock &&
        other.essential == essential &&
        other.selectMin == selectMin &&
        other.selectMax == selectMax &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        listEquals(other.itemList, itemList);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        stockCheck.hashCode ^
        stock.hashCode ^
        essential.hashCode ^
        selectMin.hashCode ^
        selectMax.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        itemList.hashCode;
  }
}
