import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatelessWidget {
  final dynamic _locale;
  final CalendarController _calendarController;
  final Function(DateTime day, List events, List holidays) onDaySelected;

  const Calendar(
    this._locale,
    this._calendarController, {
    Key key,
    this.onDaySelected,
  }) : super(key: key);

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
    );
  }
}
