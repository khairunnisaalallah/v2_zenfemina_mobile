import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:zenfemina_v2/pages/utils.dart';
import 'package:zenfemina_v2/api_repository.dart'; // Pastikan ini adalah path yang benar ke api_repository

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
  void initState() {
    super.initState();
    _fetchCycleData();
  }

  Future<void> _fetchCycleData() async {
    try {
      final datahist = await ApiRepository().getCycleData(
          'hist'); // Pastikan ini adalah cara yang benar untuk memanggil API
      final dataest = await ApiRepository().getCycleData('est');

      // Log untuk memeriksa struktur data yang diterima
      print('Data Hist: $datahist');
      print('Data Est: $dataest');

      final histCycle = datahist['data'];
      final estCycle = dataest['data'];

      if (histCycle != null) {
        setState(() {
          _rangeStart = DateTime.parse(histCycle['start_date']);
          _rangeEnd = histCycle['end_date'] != null
              ? DateTime.parse(histCycle['end_date'])
              : null;

          // Update focusedDay to start of range
          _focusedDay = _rangeStart!;
        });
      } else if (estCycle != null) {
        setState(() {
          _rangeStart = DateTime.parse(estCycle['start_date']);
          _rangeEnd = estCycle['end_date'] != null
              ? DateTime.parse(estCycle['end_date'])
              : null;

          // Update focusedDay to start of range
          _focusedDay = _rangeStart!;
        });
      } else {
        print('No cycle data found in response');
      }
    } catch (error) {
      print('Failed to fetch cycle data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 20),
          TableCalendar(
            firstDay: kFirstDay,
            lastDay: kLastDay,
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            rangeStartDay: _rangeStart,
            rangeEndDay: _rangeEnd,
            calendarFormat: _calendarFormat,
            rangeSelectionMode: _rangeSelectionMode,
            calendarStyle: CalendarStyle(
              rangeHighlightColor: Color(0xFFDA4256).withOpacity(0.3),
              rangeStartDecoration: BoxDecoration(
                color: Color(0xFFDA4256).withOpacity(1),
                shape: BoxShape.circle, // atau bentuk lainnya
              ),
              rangeEndDecoration: BoxDecoration(
                color: Color(0xFFDA4256).withOpacity(1),
                shape: BoxShape.circle, // atau bentuk lainnya
              ),
            ),
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                  _rangeStart = null; // Penting untuk membersihkan ini
                  _rangeEnd = null;
                  _rangeSelectionMode = RangeSelectionMode.toggledOff;
                });
              }
            },
            onRangeSelected: (start, end, focusedDay) {
              setState(() {
                _selectedDay = null;
                _focusedDay = focusedDay;
                _rangeStart = start;
                _rangeEnd = end;
                _rangeSelectionMode = RangeSelectionMode.toggledOff;
              });
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          )
        ],
      ),
    );
  }
}
