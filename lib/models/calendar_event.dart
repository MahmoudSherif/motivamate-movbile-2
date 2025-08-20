import 'package:uuid/uuid.dart';

class CalendarEvent {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final DateTime? startTime;
  final DateTime? endTime;
  final String color;
  final bool isAllDay;

  CalendarEvent({
    String? id,
    required this.title,
    this.description = '',
    required this.date,
    this.startTime,
    this.endTime,
    this.color = '#1A6B6B',
    this.isAllDay = false,
  }) : id = id ?? const Uuid().v4();

  CalendarEvent copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? date,
    DateTime? startTime,
    DateTime? endTime,
    String? color,
    bool? isAllDay,
  }) {
    return CalendarEvent(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      color: color ?? this.color,
      isAllDay: isAllDay ?? this.isAllDay,
    );
  }

  bool get hasTime => startTime != null;
  
  String get timeRange {
    if (!hasTime || isAllDay) return 'All day';
    if (endTime == null) {
      return '${_formatTime(startTime!)}';
    }
    return '${_formatTime(startTime!)} - ${_formatTime(endTime!)}';
  }

  String _formatTime(DateTime time) {
    final hour = time.hour == 0 ? 12 : (time.hour > 12 ? time.hour - 12 : time.hour);
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }
}