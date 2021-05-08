import 'package:daily_log/data/models/log_entry.model.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

// TODO: change it with flutter_calendar_carousel

class Calendar extends StatelessWidget {
  final dynamic _locale;
  final DateTime focusedDay;
  final Function(DateTime selectedDay, DateTime focusedDay) onDaySelected;
  final List<LogEntryModel> logEntries;

  const Calendar(
    this._locale, {
    Key? key,
    required this.onDaySelected,
    required this.logEntries,
    required this.focusedDay,
  })   : assert(_locale != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    print(focusedDay);
    return TableCalendar(
      startingDayOfWeek: StartingDayOfWeek.monday,
      locale: _locale,
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white),
        rightChevronIcon: Icon(Icons.chevron_right, color: Colors.white),
        titleTextStyle: TextStyle(color: Colors.white),
      ),
      calendarFormat: CalendarFormat.week,
      selectedDayPredicate: (day) => isSameDay(focusedDay, day),
      onDaySelected: onDaySelected,
      calendarStyle: CalendarStyle(
        defaultTextStyle: TextStyle(color: Colors.grey),
        // selectedDecoration: Theme.of(context).primaryColorLight.withOpacity(.5),
        // todayDecoration: Theme.of(context).primaryColorDark.withOpacity(.2),
        selectedTextStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        todayTextStyle: TextStyle(color: Colors.grey),
        // markerDecoration: Colors.lightBlueAccent,
      ),
      eventLoader: _buildEvents,
      lastDay: DateTime.now().add(Duration(days: 30)),
      firstDay: DateTime.now().subtract(Duration(days: 90)),
      focusedDay: focusedDay,
    );
  }

  List _buildEvents(DateTime day) {
    print('events: ${day.toString()}');
    List events = this.logEntries.where((element) => element.assignedDateTime.difference(day).inDays == 0).toList();
    return events;
  }
}
