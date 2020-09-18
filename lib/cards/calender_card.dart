import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderCard extends StatefulWidget {
  @override
  _CalenderCardState createState() => _CalenderCardState();
}

class _CalenderCardState extends State<CalenderCard>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  CalendarController _calendarController;

  @override
  void initState() {
    _calendarController = CalendarController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    super.initState();
    _animationController.forward();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TableCalendar(
            calendarController: _calendarController,
            startingDayOfWeek: StartingDayOfWeek.sunday,
            initialCalendarFormat: CalendarFormat.week,
            availableGestures: AvailableGestures.all,
            availableCalendarFormats: const {
              CalendarFormat.month: '',
              CalendarFormat.week: '',
            },
            calendarStyle: CalendarStyle(
              selectedColor: Colors.deepOrange,
              todayColor: Colors.deepOrange[200],
              outsideDaysVisible: true,
            ),
            headerStyle: HeaderStyle(
              centerHeaderTitle: true,
              formatButtonVisible: false,
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
