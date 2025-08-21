import 'package:uuid/uuid.dart';

enum AchievementCategory {
  tasks,
  focus,
  streaks,
  challenges,
  social,
  notes,
}

class Achievement {
  final String id;
  final String title;
  final String description;
  final String iconData;
  final AchievementCategory category;
  final int targetValue;
  final int currentValue;
  final bool isUnlocked;
  final DateTime? unlockedAt;
  final int points;

  Achievement({
    String? id,
    required this.title,
    required this.description,
    required this.iconData,
    required this.category,
    required this.targetValue,
    this.currentValue = 0,
    this.isUnlocked = false,
    this.unlockedAt,
    this.points = 10,
  }) : id = id ?? const Uuid().v4();

  double get progress {
    if (targetValue == 0) return 1.0;
    return (currentValue / targetValue).clamp(0.0, 1.0);
  }

  bool get canUnlock => currentValue >= targetValue && !isUnlocked;

  Achievement copyWith({
    String? id,
    String? title,
    String? description,
    String? iconData,
    AchievementCategory? category,
    int? targetValue,
    int? currentValue,
    bool? isUnlocked,
    DateTime? unlockedAt,
    int? points,
  }) {
    return Achievement(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      iconData: iconData ?? this.iconData,
      category: category ?? this.category,
      targetValue: targetValue ?? this.targetValue,
      currentValue: currentValue ?? this.currentValue,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      unlockedAt: unlockedAt ?? this.unlockedAt,
      points: points ?? this.points,
    );
  }

  static List<Achievement> getDefaultAchievements() {
    return [
      Achievement(
        title: 'First Task',
        description: 'Complete your first task',
        iconData: 'task_alt',
        category: AchievementCategory.tasks,
        targetValue: 1,
        points: 5,
      ),
      Achievement(
        title: 'Task Master',
        description: 'Complete 100 tasks',
        iconData: 'emoji_events',
        category: AchievementCategory.tasks,
        targetValue: 100,
        points: 50,
      ),
      Achievement(
        title: 'Focus Beginner',
        description: 'Focus for 1 hour total',
        iconData: 'timer',
        category: AchievementCategory.focus,
        targetValue: 60,
        points: 10,
      ),
      Achievement(
        title: 'Focus Expert',
        description: 'Focus for 100 hours total',
        iconData: 'psychology',
        category: AchievementCategory.focus,
        targetValue: 6000,
        points: 100,
      ),
      Achievement(
        title: 'Streak Starter',
        description: 'Maintain a 7-day streak',
        iconData: 'local_fire_department',
        category: AchievementCategory.streaks,
        targetValue: 7,
        points: 20,
      ),
      Achievement(
        title: 'Streak Legend',
        description: 'Maintain a 30-day streak',
        iconData: 'whatshot',
        category: AchievementCategory.streaks,
        targetValue: 30,
        points: 100,
      ),
    ];
  }
}