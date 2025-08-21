import 'package:uuid/uuid.dart';

enum GoalType { task, focus, habit, custom }

class Goal {
  final String id;
  final String title;
  final String description;
  final GoalType type;
  final int targetValue;
  final int currentValue;
  final String unit; // e.g., 'tasks', 'minutes', 'hours'
  final DateTime startDate;
  final DateTime targetDate;
  final bool isCompleted;
  final DateTime? completedAt;

  Goal({
    String? id,
    required this.title,
    this.description = '',
    required this.type,
    required this.targetValue,
    this.currentValue = 0,
    this.unit = '',
    DateTime? startDate,
    required this.targetDate,
    this.isCompleted = false,
    this.completedAt,
  }) : id = id ?? const Uuid().v4(),
       startDate = startDate ?? DateTime.now();

  double get progress {
    if (targetValue == 0) return 1.0;
    return (currentValue / targetValue).clamp(0.0, 1.0);
  }

  bool get isOverdue => !isCompleted && DateTime.now().isAfter(targetDate);
  
  int get daysRemaining {
    final now = DateTime.now();
    if (now.isAfter(targetDate)) return 0;
    return targetDate.difference(now).inDays;
  }

  String get progressText {
    if (unit.isEmpty) {
      return '$currentValue / $targetValue';
    }
    return '$currentValue / $targetValue $unit';
  }

  Goal copyWith({
    String? id,
    String? title,
    String? description,
    GoalType? type,
    int? targetValue,
    int? currentValue,
    String? unit,
    DateTime? startDate,
    DateTime? targetDate,
    bool? isCompleted,
    DateTime? completedAt,
  }) {
    return Goal(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      targetValue: targetValue ?? this.targetValue,
      currentValue: currentValue ?? this.currentValue,
      unit: unit ?? this.unit,
      startDate: startDate ?? this.startDate,
      targetDate: targetDate ?? this.targetDate,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt ?? this.completedAt,
    );
  }
}