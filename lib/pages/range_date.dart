// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:zenfemina_v2/pages/utils.dart';
import 'package:zenfemina_v2/shared/shared.dart';

class TableRangeExample extends StatefulWidget {
  @override
  _TableRangeExampleState createState() => _TableRangeExampleState();
}

class _TableRangeExampleState extends State<TableRangeExample> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOn; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: Text('TableCalendar - Range'),
          ),
      body: TableCalendar(
        headerStyle: HeaderStyle(
          headerPadding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
          titleCentered: true,
          formatButtonVisible: false,
          titleTextStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          headerMargin: EdgeInsets.only(bottom: 10),
        ),
        firstDay: kFirstDay,
        lastDay: kLastDay,
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        rangeStartDay: _rangeStart,
        rangeEndDay: _rangeEnd,
        calendarStyle: CalendarStyle(
          rangeHighlightColor:
              Color(0xFFDA4256).withOpacity(0.25), //ini warna range date
          todayDecoration: BoxDecoration(
            color: Color(0xFFDA4256), // ini warna tgl hari ini
            shape: BoxShape.circle,
          ),
          selectedDecoration: BoxDecoration(
            color: Color(0xFFDA4256), // ini ga bisa diubah warnnaya
          ),
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekendStyle:
              TextStyle(color: Color(0xFFDA4256)), //ini tulisan sun sama sat
        ),
        calendarFormat: _calendarFormat,
        rangeSelectionMode:  _rangeSelectionMode = RangeSelectionMode.disabled,
        // rangeSelectionMode: _rangeSelectionMode,
        // onDaySelected: (selectedDay, focusedDay) {
        //   {
        //     setState(() {
        //       _selectedDay = selectedDay;
        //       _focusedDay = focusedDay;
        //       _rangeStart = null; // Penting untuk membersihkan yang sebelumnya
        //       _rangeEnd = null;
        //       _rangeSelectionMode = RangeSelectionMode.toggledOff;
        //     });
        //   }
        // },
        // onRangeSelected: (start, end, focusedDay) {
        //   setState(() {
        //     _selectedDay = null;
        //     _focusedDay = focusedDay;
        //     _rangeStart = start;
        //     _rangeEnd = end;
        //     _rangeSelectionMode = RangeSelectionMode.toggledOn;
        //   });
        // },
        // onFormatChanged: (format) {
        //   if (_calendarFormat != format) {
        //     setState(() {
        //       _calendarFormat = format;
        //     });
        //   }
        // },
        // onPageChanged: (focusedDay) {
        //   _focusedDay = focusedDay;
        // },
      ),
    );
  }
}
