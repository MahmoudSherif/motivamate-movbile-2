import 'package:uuid/uuid.dart';

class Challenge {
  final String id;
  final String code;
  final String title;
  final String description;
  final String adminId;
  final List<String> participantIds;
  final DateTime startDate;
  final DateTime endDate;
  final bool isActive;
  final Map<String, int> participantScores;

  Challenge({
    String? id,
    String? code,
    required this.title,
    this.description = '',
    required this.adminId,
    List<String>? participantIds,
    DateTime? startDate,
    required this.endDate,
    this.isActive = true,
    Map<String, int>? participantScores,
  }) : id = id ?? const Uuid().v4(),
       code = code ?? _generateChallengeCode(),
       participantIds = participantIds ?? [],
       startDate = startDate ?? DateTime.now(),
       participantScores = participantScores ?? {};

  static String _generateChallengeCode() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    return String.fromCharCodes(
      Iterable.generate(6, (_) => chars.codeUnitAt(
        DateTime.now().millisecondsSinceEpoch % chars.length
      ))
    );
  }

  bool get isExpired => DateTime.now().isAfter(endDate);
  bool get hasStarted => DateTime.now().isAfter(startDate);
  
  int getParticipantScore(String userId) {
    return participantScores[userId] ?? 0;
  }

  List<MapEntry<String, int>> getLeaderboard() {
    final entries = participantScores.entries.toList();
    entries.sort((a, b) => b.value.compareTo(a.value));
    return entries;
  }

  String? getWinner() {
    if (!isExpired) return null;
    final leaderboard = getLeaderboard();
    return leaderboard.isNotEmpty ? leaderboard.first.key : null;
  }

  Challenge copyWith({
    String? id,
    String? code,
    String? title,
    String? description,
    String? adminId,
    List<String>? participantIds,
    DateTime? startDate,
    DateTime? endDate,
    bool? isActive,
    Map<String, int>? participantScores,
  }) {
    return Challenge(
      id: id ?? this.id,
      code: code ?? this.code,
      title: title ?? this.title,
      description: description ?? this.description,
      adminId: adminId ?? this.adminId,
      participantIds: participantIds ?? this.participantIds,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isActive: isActive ?? this.isActive,
      participantScores: participantScores ?? this.participantScores,
    );
  }
}