import 'package:flutter/material.dart';
import '../models/task.dart';
import '../models/challenge.dart';

class TaskProvider extends ChangeNotifier {
  final List<Task> _tasks = [];
  final List<Challenge> _challenges = [];

  List<Task> get tasks => List.unmodifiable(_tasks);
  List<Challenge> get challenges => List.unmodifiable(_challenges);

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void updateTask(Task task) {
    final index = _tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      _tasks[index] = task;
      notifyListeners();
    }
  }

  void deleteTask(String taskId) {
    _tasks.removeWhere((task) => task.id == taskId);
    notifyListeners();
  }

  void toggleTaskCompletion(String taskId) {
    final index = _tasks.indexWhere((task) => task.id == taskId);
    if (index != -1) {
      _tasks[index] = _tasks[index].copyWith(
        isCompleted: !_tasks[index].isCompleted,
        completedAt: _tasks[index].isCompleted ? null : DateTime.now(),
      );
      notifyListeners();
    }
  }

  void addChallenge(Challenge challenge) {
    _challenges.add(challenge);
    notifyListeners();
  }

  void joinChallenge(String challengeCode) {
    // Implementation for joining challenge by code
    // This would typically involve Firebase operations
  }

  List<Task> getTasksForDate(DateTime date) {
    return _tasks.where((task) {
      if (task.dueDate == null) return false;
      return task.dueDate!.year == date.year &&
             task.dueDate!.month == date.month &&
             task.dueDate!.day == date.day;
    }).toList();
  }

  List<Task> getTodayTasks() {
    return getTasksForDate(DateTime.now());
  }

  double getTodayProgress() {
    final todayTasks = getTodayTasks();
    if (todayTasks.isEmpty) return 0.0;
    final completedTasks = todayTasks.where((task) => task.isCompleted).length;
    return completedTasks / todayTasks.length;
  }
}