import 'dart:convert';

class Notice {
  String id;
  bool enabled;
  String thumbnail;
  String type;
  String title;
  String content;
  DateTime createdAt;
  DateTime updatedAt;
  Notice({
    required this.id,
    required this.enabled,
    required this.thumbnail,
    required this.type,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  Notice copyWith({
    String? id,
    bool? enabled,
    String? thumbnail,
    String? type,
    String? title,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Notice(
      id: id ?? this.id,
      enabled: enabled ?? this.enabled,
      thumbnail: thumbnail ?? this.thumbnail,
      type: type ?? this.type,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'enabled': enabled,
      'thumbnail': thumbnail,
      'type': type,
      'title': title,
      'content': content,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory Notice.fromMap(Map<String, dynamic> map) {
    return Notice(
      id: map['id'] as String,
      enabled: map['enabled'] as bool,
      thumbnail: map['thumbnail'] as String,
      type: map['type'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Notice.fromJson(String source) => Notice.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Notice(id: $id, enabled: $enabled, thumbnail: $thumbnail, type: $type, title: $title, content: $content, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant Notice other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.enabled == enabled &&
        other.thumbnail == thumbnail &&
        other.type == type &&
        other.title == title &&
        other.content == content &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        enabled.hashCode ^
        thumbnail.hashCode ^
        type.hashCode ^
        title.hashCode ^
        content.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
