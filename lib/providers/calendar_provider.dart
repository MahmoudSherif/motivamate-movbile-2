import 'package:flutter/material.dart';
import '../models/calendar_event.dart';

class CalendarProvider extends ChangeNotifier {
  final List<CalendarEvent> _events = [];
  DateTime _selectedDate = DateTime.now();

  List<CalendarEvent> get events => List.unmodifiable(_events);
  DateTime get selectedDate => _selectedDate;

  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  void addEvent(CalendarEvent event) {
    _events.add(event);
    notifyListeners();
  }

  void updateEvent(CalendarEvent event) {
    final index = _events.indexWhere((e) => e.id == event.id);
    if (index != -1) {
      _events[index] = event;
      notifyListeners();
    }
  }

  void deleteEvent(String eventId) {
    _events.removeWhere((event) => event.id == eventId);
    notifyListeners();
  }

  List<CalendarEvent> getEventsForDate(DateTime date) {
    return _events.where((event) {
      return event.date.year == date.year &&
             event.date.month == date.month &&
             event.date.day == date.day;
    }).toList();
  }

  List<CalendarEvent> getEventsForSelectedDate() {
    return getEventsForDate(_selectedDate);
  }

  bool hasEventsOnDate(DateTime date) {
    return _events.any((event) {
      return event.date.year == date.year &&
             event.date.month == date.month &&
             event.date.day == date.day;
    });
  }
}