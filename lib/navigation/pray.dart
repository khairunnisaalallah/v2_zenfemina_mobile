import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  bool isLoading = false; // Untuk menentukan apakah sedang memuat
  bool invalidCity = false;
  TextEditingController _cityController = TextEditingController();
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  _loadSavedData() async {
    _prefs = await SharedPreferences.getInstance();
    String? savedCity = _prefs.getString('city');
    if (savedCity != null) {
      _cityController.text = savedCity;
      fetchPrayerTimes(savedCity);
    }
  }

  Future<void> fetchPrayerTimes(String city) async {
    setState(() {
      isLoading = true; // Mulai memuat
    });

    try {
      final response = await http.get(Uri.parse(
          'http://api.aladhan.com/v1/timingsByCity?city=$city&country=Indonesia'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        setState(() {
          isLoading = false; // Berhenti memuat setelah mendapatkan respons
          if (data['data'] != null) {
            if (_isInvalidPrayerTimes(data['data']['timings'])) {
              invalidCity = true;
              print(
                  'Kota yang Anda masukkan tidak dikenali. Silakan coba lagi dengan nama kota yang berbeda.');
              prayerTimes.clear();
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
      setState(() {
        isLoading = false; // Berhenti memuat jika terjadi kesalahan
      });
      print("Error fetching prayer times: $e");
    }
  }

  _saveCity(String city) async {
    await _prefs.setString('city', city);
  }

  bool _isInvalidPrayerTimes(Map<String, dynamic> timings) {
    return timings['Fajr'] == "04:46" &&
        timings['Dhuhr'] == "12:12" &&
        timings['Asr'] == "15:37" &&
        timings['Maghrib'] == "18:14" &&
        timings['Isha'] == "19:28";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
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
                top: 40,
                left: 25,
                right: 25,
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
                          'Dapatkan jadwal sholat sesuai dengan kota anda!',
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
                top: 40,
                right: 25,
                child: Row(
                  children: [
                    SizedBox(width: 230),
                    IconButton(
                      icon: Icon(Icons.notifications, color: Colors.white),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 140,
                left: 25,
                right: 25,
                child: buildLocationSearch(),
              ),
              Positioned(
                top: 200,
                left: 25,
                right: 25,
                child: prayerDate(),
              ),
              Positioned(
                top: 360,
                left: 22,
                right: 22,
                child: buildPrayerTimes(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLocationSearch() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: TextField(
        controller: _cityController,
        onSubmitted: (value) {
          fetchPrayerTimes(value);
          _saveCity(value);
        },
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Cari Lokasi',
          hintStyle: TextStyle(color: Colors.black),
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
    return isLoading
        ? Center(
            child: CircularProgressIndicator(), // Tampilkan indikator loading jika sedang memuat
          )
        : Container(
            padding: EdgeInsets.all(16),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Jadwal Sholat',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                if (prayerTimes.isNotEmpty) ...[
                  buildPrayerTimeItem('Shubuh', prayerTimes['Fajr'] ?? '', FontAwesomeIcons.cloudSun),
                  buildPrayerTimeItem('Dzuhur', prayerTimes['Dhuhr'] ?? '', FontAwesomeIcons.sun),
                  buildPrayerTimeItem('Ashar', prayerTimes['Asr'] ?? '', FontAwesomeIcons.cloudMeatball),
                  buildPrayerTimeItem('Maghrib', prayerTimes['Maghrib'] ?? '', FontAwesomeIcons.cloudMoon),
                  buildPrayerTimeItem('Isya', prayerTimes['Isha'] ?? '', FontAwesomeIcons.moon),
                ] else ...[
                  Text('Tidak ada data jadwal sholat yang tersedia.'),
                ],
              ],
            ),
          );
  }

  Widget buildPrayerTimeItem(String title, String time, IconData icon) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              FaIcon(icon, color: Color(0xFFDA4256)),
              SizedBox(width: 10),
              Text(
                '$title: ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
          Text(
            time,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

