// // Copyright 2019 Aleksander Woźniak
// // SPDX-License-Identifier: Apache-2.0

// import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';
// import 'package:http/http.dart' as http;
// import 'package:zenfemina_v2/api_repository.dart';
// import 'dart:convert';
// import 'package:zenfemina_v2/pages/utils.dart';
// import 'package:zenfemina_v2/shared/shared.dart';

// class TableRangeExample extends StatefulWidget {
//   @override
//   _TableRangeExampleState createState() => _TableRangeExampleState();
// }

// class _TableRangeExampleState extends State<TableRangeExample> {
//   ApiRepository _apiRepository = ApiRepository();
//   CalendarFormat _calendarFormat =
//       CalendarFormat.month; // Mengubah ke CalendarFormat.months
//   RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOn;
//   DateTime _focusedDay = DateTime.now();
//   DateTime? _selectedDay;
//   DateTime? _rangeStart;
//   DateTime? _rangeEnd;
//   late DateTime _firstDay = DateTime(2020, 1, 1); // Tanggal pertama tahun 2020
//   late DateTime _lastDay =
//       DateTime(2030, 12, 31); // Tanggal terakhir tahun 2030

//   Future<void> _fetchCycleData() async {
//     try {
//       final datahist = await _apiRepository.getCycleData('hist');
//       final dataest = await _apiRepository.getCycleData('est');

//       // Print data untuk debugging
//       print(datahist);
//       print(dataest);

//       // Mengambil data dari response
//       final cycleHist = datahist['data'];
//       final cycleEst = dataest['data'];

//       if (cycleHist != null && cycleHist.isNotEmpty) {
//         setState(() {
//           _rangeStart = DateTime.parse(cycleHist['start_date']);
//           _rangeEnd = DateTime.parse(cycleHist['end_date']);

//           // Set firstDay and lastDay based on the fetched cycle range
//           _firstDay = _rangeStart!;
//           _lastDay = _rangeEnd!;
//           _focusedDay = _rangeStart!; // Update focusedDay to start of range
//         });
//       } else if (cycleEst != null && cycleEst.isNotEmpty) {
//         setState(() {
//           _rangeStart = DateTime.parse(cycleEst['start_date']);
//           _rangeEnd = DateTime.parse(cycleEst['end_date']);

//           // Set firstDay and lastDay based on the fetched cycle range
//           _firstDay = _rangeStart!;
//           _lastDay = _rangeEnd!;
//           _focusedDay = _rangeStart!; // Update focusedDay to start of range
//         });
//       } else {
//         print('No cycle data found in response');
//       }
//     } catch (error) {
//       print('Failed to fetch cycle data: $error');
//       // Jika terjadi kesalahan, biarkan rentang tanggal tetap sama
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     _fetchCycleData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           SizedBox(height: 40),
//           TableCalendar(
//             // Properti tambahan untuk menghilangkan tampilan tanggal hari ini
//             availableCalendarFormats: {
//               CalendarFormat.month: '',
//             },
//             firstDay: _firstDay,
//             lastDay: _lastDay,
//             focusedDay: _focusedDay,
//             rangeStartDay: _rangeStart,
//             rangeEndDay: _rangeEnd,
//             calendarFormat: _calendarFormat,
//             headerStyle: HeaderStyle(
//               headerPadding:
//                   EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
//               titleCentered: true,
//               formatButtonVisible: false,
//               titleTextStyle: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//               ),
//               headerMargin: EdgeInsets.only(bottom: 10),
//             ),
//             calendarStyle: CalendarStyle(
//               rangeHighlightColor: Color(0xFFDA4256).withOpacity(0.25),
//               todayDecoration: BoxDecoration(
//                 color: Color(0xFFDA4256),
//                 shape: BoxShape.circle,
//               ),
//               selectedDecoration: BoxDecoration(
//                 color: Color(0xFFDA4256),
//               ),
//             ),
//             daysOfWeekStyle: DaysOfWeekStyle(
//               weekendStyle: TextStyle(color: Color(0xFFDA4256)),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
