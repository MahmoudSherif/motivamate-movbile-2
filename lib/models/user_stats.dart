class UserStats {
  final int totalTasks;
  final int completedTasks;
  final int totalFocusTime; // in minutes
  final int currentStreak;
  final int longestStreak;
  final int totalAchievements;
  final int totalChallengesWon;
  final int totalNotes;
  final Map<String, int> dailyActivity; // date -> minutes

  UserStats({
    this.totalTasks = 0,
    this.completedTasks = 0,
    this.totalFocusTime = 0,
    this.currentStreak = 0,
    this.longestStreak = 0,
    this.totalAchievements = 0,
    this.totalChallengesWon = 0,
    this.totalNotes = 0,
    Map<String, int>? dailyActivity,
  }) : dailyActivity = dailyActivity ?? {};

  factory UserStats.empty() {
    return UserStats();
  }

  double get completionRate {
    if (totalTasks == 0) return 0.0;
    return completedTasks / totalTasks;
  }

  String get totalFocusTimeFormatted {
    if (totalFocusTime < 60) {
      return '${totalFocusTime}m';
    }
    final hours = totalFocusTime ~/ 60;
    final minutes = totalFocusTime % 60;
    if (minutes == 0) {
      return '${hours}h';
    }
    return '${hours}h ${minutes}m';
  }

  int getTotalFocusHours() {
    return totalFocusTime ~/ 60;
  }

  List<MapEntry<String, int>> getRecentActivity(int days) {
    final now = DateTime.now();
    final recent = <MapEntry<String, int>>[];
    
    for (int i = days - 1; i >= 0; i--) {
      final date = now.subtract(Duration(days: i));
      final dateKey = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
      final minutes = dailyActivity[dateKey] ?? 0;
      recent.add(MapEntry(dateKey, minutes));
    }
    
    return recent;
  }

  UserStats copyWith({
    int? totalTasks,
    int? completedTasks,
    int? totalFocusTime,
    int? currentStreak,
    int? longestStreak,
    int? totalAchievements,
    int? totalChallengesWon,
    int? totalNotes,
    Map<String, int>? dailyActivity,
  }) {
    return UserStats(
      totalTasks: totalTasks ?? this.totalTasks,
      completedTasks: completedTasks ?? this.completedTasks,
      totalFocusTime: totalFocusTime ?? this.totalFocusTime,
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      totalAchievements: totalAchievements ?? this.totalAchievements,
      totalChallengesWon: totalChallengesWon ?? this.totalChallengesWon,
      totalNotes: totalNotes ?? this.totalNotes,
      dailyActivity: dailyActivity ?? this.dailyActivity,
    );
  }
}