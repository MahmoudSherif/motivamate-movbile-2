import 'package:flutter/material.dart';
import '../models/user_stats.dart';
import '../models/achievement.dart';
import '../models/goal.dart';

class ProfileProvider extends ChangeNotifier {
  UserStats _stats = UserStats.empty();
  final List<Achievement> _achievements = [];
  final List<Goal> _goals = [];

  UserStats get stats => _stats;
  List<Achievement> get achievements => List.unmodifiable(_achievements);
  List<Goal> get goals => List.unmodifiable(_goals);

  void updateStats(UserStats newStats) {
    _stats = newStats;
    notifyListeners();
  }

  void addAchievement(Achievement achievement) {
    _achievements.add(achievement);
    notifyListeners();
  }

  void addGoal(Goal goal) {
    _goals.add(goal);
    notifyListeners();
  }

  void updateGoal(Goal goal) {
    final index = _goals.indexWhere((g) => g.id == goal.id);
    if (index != -1) {
      _goals[index] = goal;
      notifyListeners();
    }
  }

  void completeGoal(String goalId) {
    final index = _goals.indexWhere((g) => g.id == goalId);
    if (index != -1) {
      _goals[index] = _goals[index].copyWith(
        isCompleted: true,
        completedAt: DateTime.now(),
      );
      notifyListeners();
    }
  }

  List<Achievement> getUnlockedAchievements() {
    return _achievements.where((a) => a.isUnlocked).toList();
  }

  List<Goal> getActiveGoals() {
    return _goals.where((g) => !g.isCompleted).toList();
  }

  List<Goal> getCompletedGoals() {
    return _goals.where((g) => g.isCompleted).toList();
  }

  double getGoalsCompletionRate() {
    if (_goals.isEmpty) return 0.0;
    final completed = _goals.where((g) => g.isCompleted).length;
    return completed / _goals.length;
  }
}