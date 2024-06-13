import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;
import 'package:zenfemina_v2/pages/prayer_type.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:zenfemina_v2/widgets/city_data.dart'; // Import data kota

class PrayPage extends StatefulWidget {
  const PrayPage({Key? key}) : super(key: key);

  @override
  _PrayPageState createState() => _PrayPageState();
}

class _PrayPageState extends State<PrayPage> {
  Map<String, String> prayerTimes = {};
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  bool invalidCity = false;
  String selectedCity = '';
  @override
  void initState() {
    super.initState();
    _loadSelectedCity();
  }

  Future<void> _loadSelectedCity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedCity = prefs.getString('selectedCity') ?? '';
    });
    if (selectedCity.isNotEmpty) {
      fetchPrayerTimes(selectedCity);
    }
  }

  Future<void> _refreshPrayerTimes() async {
    if (selectedCity.isNotEmpty) {
      await fetchPrayerTimes(selectedCity);
    }
  }

  Future<void> fetchPrayerTimes(String city) async {
    try {
      final response = await http.get(Uri.parse(
          'http://api.aladhan.com/v1/timingsByCity?city=$city&country=Indonesia'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        print('Data received: $data');
        setState(() {
          if (data['data'] != null) {
            if (_isInvalidPrayerTimes(data['data']['timings'])) {
              invalidCity = true;
              print('Kota yang Anda masukkan tidak dikenali.');
            } else {
              invalidCity = false;
              prayerTimes = Map<String, String>.from(data['data']['timings']);
              print('Prayer times: $prayerTimes');
            }
          } else {
            print('No prayer times data available.');
          }
        });
      } else {
        throw Exception('Failed to load prayer times');
      }
    } catch (e) {
      print("Error fetching prayer times: $e");
    }
  }

  bool _isInvalidPrayerTimes(Map<String, dynamic> timings) {
    return timings['Fajr'] == "-" &&
        timings['Dhuhr'] == "-" &&
        timings['Asr'] == "-" &&
        timings['Maghrib'] == "-" &&
        timings['Isha'] == "-";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: _refreshPrayerTimes,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 200,
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
                Positioned(
                  top: 70,
                  left: 30,
                  right: 30,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0, left: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Jadwal Sholat Kota ${selectedCity}',
                          style: GoogleFonts.poppins(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          'Dapatkan jadwal sholat sesuai dengan kota anda!',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
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
                          hour: prayerTimes['Fajr'] ?? "-",
                          press: () {},
                        ),
                        PrayerType(
                          text: "Dzuhur",
                          icon: 0xeef8,
                          hour: prayerTimes['Dhuhr'] ?? "-",
                          press: () {},
                        ),
                        PrayerType(
                          text: "Ashar",
                          icon: 0xeef9,
                          hour: prayerTimes['Asr'] ?? "-",
                          press: () {},
                        ),
                        PrayerType(
                          text: "Maghrib",
                          icon: 0xeef5,
                          hour: prayerTimes['Maghrib'] ?? "-",
                          press: () {},
                        ),
                        PrayerType(
                          text: "Isya",
                          icon: 0xf5e2,
                          hour: prayerTimes['Isha'] ?? "-",
                          press: () {},
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget prayerDate() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 3,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TableCalendar(
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
          rangeHighlightColor: Color(0xFFDA4256).withOpacity(0.25),
          todayDecoration: BoxDecoration(
            color: Color(0xFFDA4256),
            shape: BoxShape.circle,
          ),
          selectedDecoration: BoxDecoration(
            color: Color(0xFFDA4256),
          ),
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekendStyle: TextStyle(color: Colors.red),
        ),
        calendarFormat: CalendarFormat.week,
        rangeSelectionMode: RangeSelectionMode.toggledOn,
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
          });
        },
      ),
    );
  }

  Widget buildPrayerTimes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Jadwal Sholat',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        if (prayerTimes.isNotEmpty) ...[
          buildPrayerTimeItem('Shubuh', prayerTimes['Fajr'] ?? ''),
          buildPrayerTimeItem('Dzuhur', prayerTimes['Dhuhr'] ?? ''),
          buildPrayerTimeItem('Ashar', prayerTimes['Asr'] ?? ''),
          buildPrayerTimeItem('Maghrib', prayerTimes['Maghrib'] ?? ''),
          buildPrayerTimeItem('Isya', prayerTimes['Isha'] ?? ''),
        ] else ...[
          Text('Tidak ada data jadwal sholat yang tersedia.'),
        ],
      ],
    );
  }

  Widget buildPrayerTimeItem(String title, String time) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('$title: ', style: TextStyle(fontWeight: FontWeight.bold)),
        Text(time),
      ],
    );
  }
}
