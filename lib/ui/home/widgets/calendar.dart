import 'package:daily_log/data/models/log_entry.model.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatelessWidget {
  final dynamic _locale;
  final CalendarController _calendarController;
  final DateTime initialDateSelected;
  final Function(DateTime day, List events, List holidays) onDaySelected;
  final List<LogEntryModel> logEntries;

  const Calendar(
    this._locale,
    this._calendarController, {
    Key key,
    @required this.onDaySelected,
    @required this.logEntries,
    @required this.initialDateSelected,
  })  : assert(_locale != null),
        assert(_calendarController != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      startingDayOfWeek: StartingDayOfWeek.monday,
      locale: _locale,
      headerStyle: HeaderStyle(formatButtonVisible: false, centerHeaderTitle: true),
      initialCalendarFormat: CalendarFormat.week,
      calendarController: _calendarController,
      onDaySelected: onDaySelected,
      calendarStyle: CalendarStyle(
        selectedColor: Theme.of(context).primaryColorDark,
        todayColor: Theme.of(context).primaryColorLight,
      ),
      initialSelectedDay: initialDateSelected ?? DateTime.now(),
      events: _buildEvents(),
    );
  }

  Map<DateTime, List> _buildEvents() {
    Map<DateTime, List> events = Map();
    this.logEntries.forEach((element) {
      var existing = events[element.assignedDateTime];
      events[element.assignedDateTime] = []..add(element);
      if (existing != null) events[element.assignedDateTime].add(existing);
    });
    return events;
  }
}
