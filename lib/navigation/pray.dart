import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:zenfemina_v2/pages/prayer_type.dart';
import 'package:zenfemina_v2/pages/profile_menu.dart';
import 'package:zenfemina_v2/pages/range_date.dart';
import 'package:zenfemina_v2/widgets/circle_button.dart';

class prayPage extends StatelessWidget {
  const prayPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context)
              .size
              .height, // Sesuaikan tinggi dengan tinggi layar
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 210,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    color: Color(0xFFDA4256),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.35),
                        spreadRadius: 0,
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                ),
              ),
              // yg merah2 itu
              Positioned(
                top: 50,
                left: 25,
                child: Padding(
                  padding: const EdgeInsets.only(top: 0, left: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Jadwal sholat',
                        style: GoogleFonts.outfit(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Container(
                        width: 250,
                        height: 50,
                        child: Text(
                          'Dapatkan jadwal sholat sesuai dengan alamat anda !',
                          style: GoogleFonts.outfit(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 50,
                right: 25,
                child: Row(
                  children: [
                    SizedBox(width: 230),
                    CircleButton(
                      icon: Icons.notifications,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 160,
                left: 20,
                right: 20,
                child: Container(
                  width: 300,
                  height: 130,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset: Offset(0, 3), // perubahan posisi bayangan jika diperlukan
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 160,
                left: 25,
                right: 25,
                child: prayerDate(),
              ),
              Positioned(
                top: 320,
                left: 22,
                right: 22,
                child: Column(
                  children: [
                    PrayerType(
                      text: "Shubuh",
                      icon: 0xf5e4,
                      hour: "04:54",
                      press: () {},
                    ),
                    PrayerType(
                      text: "Dzuhur",
                      icon: 0xeef8,
                      hour: "11:54",
                      press: () {},
                    ),
                    PrayerType(
                      text: "Ashar",
                      icon: 0xeef9,
                      hour: "15:00",
                      press: () {},
                    ),
                    PrayerType(
                      text: "Magrib",
                      icon: 0xeef5,
                      hour: "17:10",
                      press: () {},
                    ),
                    PrayerType(
                      text: "Isya",
                      icon: 0xf5e2,
                      hour: "19:45",
                      press: () {},
                    ),
                  ],
                )
              )
            ],
          ),
        ),
      ),
    );
  }

  Container prayerDate() {
    DateTime? _selectedDay;
    DateTime? _rangeStart;
    DateTime? _rangeEnd;
    return Container(
      child:  TableCalendar(
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
        firstDay: DateTime.now().subtract(Duration(days: 7)),
        lastDay: DateTime.now().add(Duration(days: 7)),
        focusedDay: DateTime.now(),
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
              TextStyle(color: Colors.red), //ini tulisan sun sama sat
        ),
        calendarFormat: CalendarFormat.week,
        rangeSelectionMode: RangeSelectionMode.toggledOn,
        onDaySelected: (selectedDay, focusedDay) {{}},
      ),
    );
  }

}
