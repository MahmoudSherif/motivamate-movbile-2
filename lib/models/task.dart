import 'package:uuid/uuid.dart';

enum TaskPriority { low, medium, high }

class Task {
  final String id;
  final String title;
  final String description;
  final TaskPriority priority;
  final DateTime? dueDate;
  final bool isCompleted;
  final DateTime createdAt;
  final DateTime? completedAt;
  final String? challengeId;
  final int points;

  Task({
    String? id,
    required this.title,
    this.description = '',
    this.priority = TaskPriority.medium,
    this.dueDate,
    this.isCompleted = false,
    DateTime? createdAt,
    this.completedAt,
    this.challengeId,
    this.points = 0,
  }) : id = id ?? const Uuid().v4(),
       createdAt = createdAt ?? DateTime.now();

  Task copyWith({
    String? id,
    String? title,
    String? description,
    TaskPriority? priority,
    DateTime? dueDate,
    bool? isCompleted,
    DateTime? createdAt,
    DateTime? completedAt,
    String? challengeId,
    int? points,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      dueDate: dueDate ?? this.dueDate,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
      challengeId: challengeId ?? this.challengeId,
      points: points ?? this.points,
    );
  }

  bool get isChallengeTask => challengeId != null;
  bool get isOverdue => dueDate != null && 
                       dueDate!.isBefore(DateTime.now()) && 
                       !isCompleted;
}