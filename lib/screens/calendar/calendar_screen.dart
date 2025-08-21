import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../providers/calendar_provider.dart';
import '../../models/calendar_event.dart';
import '../../theme/app_theme.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Calendar'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddEventDialog,
          ),
        ],
      ),
      body: Consumer<CalendarProvider>(
        builder: (context, calendarProvider, child) {
          return Column(
            children: [
              // Calendar Widget
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.cardBackground,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppTheme.glassBorder),
                ),
                child: TableCalendar<CalendarEvent>(
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: _focusedDay,
                  calendarFormat: _calendarFormat,
                  eventLoader: calendarProvider.getEventsForDate,
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  calendarStyle: const CalendarStyle(
                    outsideDaysVisible: false,
                    defaultTextStyle: TextStyle(color: Colors.white),
                    weekendTextStyle: TextStyle(color: Colors.white70),
                    selectedTextStyle: TextStyle(color: Colors.white),
                    todayTextStyle: TextStyle(color: Colors.white),
                    selectedDecoration: BoxDecoration(
                      color: AppTheme.primaryTeal,
                      shape: BoxShape.circle,
                    ),
                    todayDecoration: BoxDecoration(
                      color: AppTheme.warmOrange,
                      shape: BoxShape.circle,
                    ),
                    markerDecoration: BoxDecoration(
                      color: AppTheme.primaryTeal,
                      shape: BoxShape.circle,
                    ),
                  ),
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                    titleTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    leftChevronIcon: Icon(
                      Icons.chevron_left,
                      color: Colors.white,
                    ),
                    rightChevronIcon: Icon(
                      Icons.chevron_right,
                      color: Colors.white,
                    ),
                  ),
                  daysOfWeekStyle: const DaysOfWeekStyle(
                    weekdayStyle: TextStyle(color: Colors.white70),
                    weekendStyle: TextStyle(color: Colors.white70),
                  ),
                  selectedDayPredicate: (day) {
                    return isSameDay(calendarProvider.selectedDate, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _focusedDay = focusedDay;
                    });
                    calendarProvider.setSelectedDate(selectedDay);
                  },
                  onFormatChanged: (format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  },
                  onPageChanged: (focusedDay) {
                    setState(() {
                      _focusedDay = focusedDay;
                    });
                  },
                ),
              ),

              // Events List
              Expanded(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppTheme.cardBackground,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppTheme.glassBorder),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Events for ${_formatDate(calendarProvider.selectedDate)}',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: _buildEventsList(calendarProvider.getEventsForSelectedDate()),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildEventsList(List<CalendarEvent> events) {
    if (events.isEmpty) {
      return const Center(
        child: Text(
          'No events for this day',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 16,
          ),
        ),
      );
    }

    return ListView.separated(
      itemCount: events.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final event = events[index];
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Color(int.parse(event.color.replaceFirst('#', '0xFF'))),
              width: 2,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      event.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    event.timeRange,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              if (event.description.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  event.description,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  void _showAddEventDialog() {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    TimeOfDay? startTime;
    TimeOfDay? endTime;
    bool isAllDay = false;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: AppTheme.cardBackground,
              title: const Text('Add Event', style: TextStyle(color: Colors.white)),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: 'Event Title',
                        labelStyle: TextStyle(color: Colors.white70),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Description (optional)',
                        labelStyle: TextStyle(color: Colors.white70),
                      ),
                      style: const TextStyle(color: Colors.white),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 16),
                    CheckboxListTile(
                      title: const Text('All Day', style: TextStyle(color: Colors.white)),
                      value: isAllDay,
                      onChanged: (value) {
                        setState(() {
                          isAllDay = value ?? false;
                        });
                      },
                    ),
                    if (!isAllDay) ...[
                      ListTile(
                        title: const Text('Start Time', style: TextStyle(color: Colors.white)),
                        subtitle: Text(
                          startTime?.format(context) ?? 'Select time',
                          style: const TextStyle(color: Colors.white70),
                        ),
                        onTap: () async {
                          final time = await showTimePicker(
                            context: context,
                            initialTime: startTime ?? TimeOfDay.now(),
                          );
                          if (time != null) {
                            setState(() {
                              startTime = time;
                            });
                          }
                        },
                      ),
                      ListTile(
                        title: const Text('End Time', style: TextStyle(color: Colors.white)),
                        subtitle: Text(
                          endTime?.format(context) ?? 'Select time',
                          style: const TextStyle(color: Colors.white70),
                        ),
                        onTap: () async {
                          final time = await showTimePicker(
                            context: context,
                            initialTime: endTime ?? TimeOfDay.now(),
                          );
                          if (time != null) {
                            setState(() {
                              endTime = time;
                            });
                          }
                        },
                      ),
                    ],
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (titleController.text.isNotEmpty) {
                      final calendarProvider = context.read<CalendarProvider>();
                      final selectedDate = calendarProvider.selectedDate;
                      
                      DateTime? startDateTime;
                      DateTime? endDateTime;

                      if (!isAllDay && startTime != null) {
                        startDateTime = DateTime(
                          selectedDate.year,
                          selectedDate.month,
                          selectedDate.day,
                          startTime!.hour,
                          startTime!.minute,
                        );
                        
                        if (endTime != null) {
                          endDateTime = DateTime(
                            selectedDate.year,
                            selectedDate.month,
                            selectedDate.day,
                            endTime!.hour,
                            endTime!.minute,
                          );
                        }
                      }

                      final event = CalendarEvent(
                        title: titleController.text,
                        description: descriptionController.text,
                        date: selectedDate,
                        startTime: startDateTime,
                        endTime: endDateTime,
                        isAllDay: isAllDay,
                      );

                      calendarProvider.addEvent(event);
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Add'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}