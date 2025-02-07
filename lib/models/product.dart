import 'dart:convert';
import 'package:freeorder_flutter/models/option.dart';

class Product {
  String id;
  String optionsId;
  String name;
  String categoriesId;
  String description;
  String content;
  String productImg;
  int price;
  bool stockCheck;
  int stock;
  int seq;
  DateTime createdAt;
  DateTime updatedAt;
  bool isPopular;
  bool isNew;
  bool isRecommended;
  bool checkRecommend;
  Option option;
  int quantity;
  Product({
    required this.id,
    required this.optionsId,
    required this.name,
    required this.categoriesId,
    required this.description,
    required this.content,
    required this.productImg,
    required this.price,
    required this.stockCheck,
    required this.stock,
    required this.seq,
    required this.createdAt,
    required this.updatedAt,
    required this.isPopular,
    required this.isNew,
    required this.isRecommended,
    required this.checkRecommend,
    required this.option,
    required this.quantity,
  });

  Product copyWith({
    String? id,
    String? optionsId,
    String? name,
    String? categoriesId,
    String? description,
    String? content,
    String? productImg,
    int? price,
    bool? stockCheck,
    int? stock,
    int? seq,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isPopular,
    bool? isNew,
    bool? isRecommended,
    bool? checkRecommend,
    Option? option,
    int? quantity,
  }) {
    return Product(
      id: id ?? this.id,
      optionsId: optionsId ?? this.optionsId,
      name: name ?? this.name,
      categoriesId: categoriesId ?? this.categoriesId,
      description: description ?? this.description,
      content: content ?? this.content,
      productImg: productImg ?? this.productImg,
      price: price ?? this.price,
      stockCheck: stockCheck ?? this.stockCheck,
      stock: stock ?? this.stock,
      seq: seq ?? this.seq,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isPopular: isPopular ?? this.isPopular,
      isNew: isNew ?? this.isNew,
      isRecommended: isRecommended ?? this.isRecommended,
      checkRecommend: checkRecommend ?? this.checkRecommend,
      option: option ?? this.option,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'optionsId': optionsId,
      'name': name,
      'categoriesId': categoriesId,
      'description': description,
      'content': content,
      'productImg': productImg,
      'price': price,
      'stockCheck': stockCheck,
      'stock': stock,
      'seq': seq,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
      'isPopular': isPopular,
      'isNew': isNew,
      'isRecommended': isRecommended,
      'checkRecommend': checkRecommend,
      'option': option.toMap(),
      'quantity': quantity,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as String,
      optionsId: map['optionsId'] as String,
      name: map['name'] as String,
      categoriesId: map['categoriesId'] as String,
      description: map['description'] as String,
      content: map['content'] as String,
      productImg: map['productImg'] as String,
      price: map['price'] as int,
      stockCheck: map['stockCheck'] as bool,
      stock: map['stock'] as int,
      seq: map['seq'] as int,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
      isPopular: map['isPopular'] as bool,
      isNew: map['isNew'] as bool,
      isRecommended: map['isRecommended'] as bool,
      checkRecommend: map['checkRecommend'] as bool,
      option: Option.fromMap(map['option'] as Map<String, dynamic>),
      quantity: map['quantity'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) => Product.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Product(id: $id, optionsId: $optionsId, name: $name, categoriesId: $categoriesId, description: $description, content: $content, productImg: $productImg, price: $price, stockCheck: $stockCheck, stock: $stock, seq: $seq, createdAt: $createdAt, updatedAt: $updatedAt, isPopular: $isPopular, isNew: $isNew, isRecommended: $isRecommended, checkRecommend: $checkRecommend, option: $option, quantity: $quantity)';
  }

  @override
  bool operator ==(covariant Product other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.optionsId == optionsId &&
        other.name == name &&
        other.categoriesId == categoriesId &&
        other.description == description &&
        other.content == content &&
        other.productImg == productImg &&
        other.price == price &&
        other.stockCheck == stockCheck &&
        other.stock == stock &&
        other.seq == seq &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.isPopular == isPopular &&
        other.isNew == isNew &&
        other.isRecommended == isRecommended &&
        other.checkRecommend == checkRecommend &&
        other.option == option &&
        other.quantity == quantity;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        optionsId.hashCode ^
        name.hashCode ^
        categoriesId.hashCode ^
        description.hashCode ^
        content.hashCode ^
        productImg.hashCode ^
        price.hashCode ^
        stockCheck.hashCode ^
        stock.hashCode ^
        seq.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        isPopular.hashCode ^
        isNew.hashCode ^
        isRecommended.hashCode ^
        checkRecommend.hashCode ^
        option.hashCode ^
        quantity.hashCode;
  }
}
