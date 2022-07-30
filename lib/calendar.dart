import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'utility.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime _focusedDay = DateTime.now();

  DateTime? _selectedDay;

  final Utility _utility = Utility();

  Map<DateTime, List> _eventsList = {};

  ///
  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  ///
  @override
  void initState() {
    super.initState();

    _eventsList = {
      DateTime.parse('2022-07-24'): ['', '', '', '', '', '', ''],
      DateTime.parse('2022-07-25'): ['', '', '', '', '', ''],
      DateTime.parse('2022-07-26'): ['', '', '', '', ''],
      DateTime.parse('2022-07-27'): ['', '', '', ''],

      ///

      DateTime.parse('2022-07-28'): ['', '', ''],
      DateTime.parse('2022-07-29'): ['', ''],
      DateTime.parse('2022-07-30'): [''],
    };
  }

  ///
  @override
  Widget build(BuildContext context) {
    final _events = LinkedHashMap<DateTime, List>(
      equals: isSameDay,
      hashCode: getHashCode,
    )..addAll(_eventsList);

    List getEventForDay(DateTime day) {
      return _events[day] ?? [];
    }

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          _utility.getBackGround(),
          Column(
            children: [
              const SizedBox(height: 50),
              TableCalendar(
                eventLoader: getEventForDay,

                ///

                calendarStyle: const CalendarStyle(
                  todayDecoration: BoxDecoration(color: Colors.transparent),
                  selectedDecoration: BoxDecoration(
                    color: Colors.indigo,
                    shape: BoxShape.circle,
                  ),

                  ///

                  rangeHighlightColor: Color(0xFFBBDDFF),

                  ///

                  todayTextStyle: TextStyle(color: Color(0xFFFAFAFA)),
                  selectedTextStyle: TextStyle(color: Color(0xFFFAFAFA)),
                  rangeStartTextStyle: TextStyle(color: Color(0xFFFAFAFA)),
                  rangeEndTextStyle: TextStyle(color: Color(0xFFFAFAFA)),
//              outsideTextStyle: TextStyle(color: Colors.white),
                  disabledTextStyle: TextStyle(color: Colors.grey),
                  holidayTextStyle: TextStyle(color: Color(0xFF5C6BC0)),
                  weekendTextStyle: TextStyle(color: Colors.white),

                  ///

                  markerDecoration: BoxDecoration(color: Colors.white),
                  rangeStartDecoration: BoxDecoration(color: Color(0xFF6699FF)),
                  rangeEndDecoration: BoxDecoration(color: Color(0xFF6699FF)),
                  holidayDecoration: BoxDecoration(
                    border: Border.fromBorderSide(
                      BorderSide(
                        color: Color(0xFF9FA8DA),
                      ),
                    ),
                  ),
                ),

                ///

                headerStyle: const HeaderStyle(formatButtonVisible: false),
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: _focusedDay,

                ///

                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },

                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
