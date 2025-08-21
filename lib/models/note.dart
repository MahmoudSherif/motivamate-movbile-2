import 'package:uuid/uuid.dart';

class Note {
  final String id;
  final String title;
  final String content;
  final String category;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isPinned;
  final List<String> tags;

  Note({
    String? id,
    required this.title,
    required this.content,
    this.category = '',
    DateTime? createdAt,
    DateTime? updatedAt,
    this.isPinned = false,
    List<String>? tags,
  }) : id = id ?? const Uuid().v4(),
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now(),
       tags = tags ?? [];

  Note copyWith({
    String? id,
    String? title,
    String? content,
    String? category,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isPinned,
    List<String>? tags,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      category: category ?? this.category,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isPinned: isPinned ?? this.isPinned,
      tags: tags ?? this.tags,
    );
  }

  String get preview {
    if (content.length <= 100) return content;
    return '${content.substring(0, 100)}...';
  }

  bool get isEmpty => title.isEmpty && content.isEmpty;
  
  int get wordCount => content.split(' ').where((word) => word.isNotEmpty).length;
}