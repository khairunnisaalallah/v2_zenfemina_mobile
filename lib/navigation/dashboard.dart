import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:zenfemina_v2/menu/calender.dart';
import 'package:zenfemina_v2/widgets/circle_button.dart';
import 'package:zenfemina_v2/routes.dart';
import 'package:zenfemina_v2/api_repository.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final ApiRepository _apiRepository = ApiRepository();
  String? _username = '';
  String? _startDate = '';
  int? _cycleLength = 0;
  int? _periodLength = 0;
  int? _prayingDebtsCount = 0;
  int? _fastingDebtsCount = 0;
  // ? = bisa null atau nilai integer, klo ga pake berarti ga boleh null dan harus selalu punya nilai integer
  String _cycleStatus = 'beginCycle';

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
    _loadCycleData();
    _loadDebtsData();
  }

  Future<void> _loadDebtsData() async {
    try {
      final prayingDebts = await _apiRepository.getPrayingDebts();
      final fastingDebts = await _apiRepository.getFastingDebts();
      // Tambahkan logging untuk data yang diterima dari API
      print('Praying Debts: $prayingDebts');
      print('Fasting Debts: $fastingDebts');
      setState(() {
        _prayingDebtsCount = prayingDebts.length;
        _fastingDebtsCount = fastingDebts.length;
      });
    } catch (e) {
      print('Failed to load debts data: $e');
    }
  }

  Future<void> _loadUserInfo() async {
    try {
      final userInfo = await _apiRepository.getUserInfo();
      final username =
          userInfo['data']['username']; // Mengambil nilai username dari respons

      setState(() {
        _username = username; // Menyimpan nilai username ke dalam _userName
      });
    } catch (e) {
      print('Failed to load user info: $e');
    }
  }

  Future<void> _loadCycleData() async {
  try {
    final cycleInfo = await _apiRepository.getCycleData("period");
    final startDate = cycleInfo['data']['start_date'];
    final cycleLength = cycleInfo['data']['cycle_length'];
    final periodLength = cycleInfo['data']['period_length'];

    // Debug log untuk memeriksa nilai startDate yang diterima
    print('Received start date from API: $startDate');

    // Menggunakan DateFormat untuk memastikan tanggal dalam format yang benar
    final DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    DateTime parsedStartDate;
    try {
      parsedStartDate = dateFormat.parse(startDate);
    } catch (e) {
      print('Error parsing start date: $e');
      return;
    }

    setState(() {
      _startDate = parsedStartDate.toIso8601String();
      _cycleLength = cycleLength;
      _periodLength = periodLength;
    });
  } catch (e) {
    print('Failed to load cycle data: $e');
  }
}


  String _calculateCycleDay() {
    if (_startDate != null && _cycleLength != null && _periodLength != null) {
      try {
        final DateTime startDate = DateTime.parse(_startDate!);
        final DateTime currentDate = DateTime.now();
        final int daysPassed = currentDate.difference(startDate).inDays;

        if (daysPassed < _periodLength!) {
          return 'Hari ke-${daysPassed + 1} Haid';
        } else {
          final int daysUntilNextCycle =
              _cycleLength! - (daysPassed % _cycleLength!);
          return '$daysUntilNextCycle Hari Lagi';
        }
      } catch (e) {
        print('Error calculating cycle day: $e');
        return ''; // Jika terjadi kesalahan, kembalikan string kosong
      }
    } else {
      return 'Data siklus tidak lengkap';
    }
  }

  Future<void> _updateCycleStatus() async {
    try {
      if (_cycleStatus == 'beginCycle') {
        await _apiRepository.beginCycle();
        setState(() {
          _cycleStatus = 'continueCycle';
        });
      } else if (_cycleStatus == 'continueCycle') {
        await _apiRepository.continueCycle();
        setState(() {
          _cycleStatus = 'endCycle';
        });
      } else if (_cycleStatus == 'endCycle') {
        await _apiRepository.endCycle();
        setState(() {
          _cycleStatus = 'beginCycle';
        });
      }
    } catch (e) {
      print('Failed to update cycle status: $e');
    }
  }

  String _getCycleButtonText() {
    switch (_cycleStatus) {
      case 'beginCycle':
        return 'Mulai Siklus';
      case 'continueCycle':
        return 'Lanjutkan Siklus';
      case 'endCycle':
        return 'Siklus Berakhir';
      default:
        return 'Mulai Siklus';
    }
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
                  height: 259,
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
                top: 45,
                left: 30,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 42),
                    Text(
                      'Hallo $_username',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.poppins(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Ayo mulai atur siklus haidmu !',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 50,
                right: 25,
                child: Row(
                  children: [
                    SizedBox(width: 210),
                    CircleButton(
                      icon: Icons.calendar_month,
                      onPressed: () {
                        Get.to(CalenderPage());
                      },
                    ),
                    SizedBox(width: 5),
                    CircleButton(
                      icon: Icons.notifications,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 170,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 345,
                    height: 200,
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat('dd MMMM yyyy').format(DateTime.now()),
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Color(0XFFDA4256),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          _calculateCycleDay(),
                          style: GoogleFonts.poppins(
                            fontSize: 32,
                            color: Color(0xFFDA4256),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Menuju siklus haid selanjutnya',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Color(0xFFDA4256),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _updateCycleStatus,
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Color(0xFFDAD3D3),
                            backgroundColor: Colors.white,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: BorderSide(
                                color: Color(0xFFDA4256),
                                width: 2,
                              ),
                            ),
                            minimumSize: Size(132, 35),
                          ),
                          child: Text(
                            _getCycleButtonText(),
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              color: Color(0xFFDA4256),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 390,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 30),
                        Text(
                          'Menu Lainnya',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.toNamed('/sholatpuasa');
                          },
                          child: Container(
                            width: 160,
                            height: 92,
                            decoration: BoxDecoration(
                              color: Color(0XFFFFE7E7),
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
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 40,
                                ),
                                child: Text(
                                  'Hutang Sholat',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        InkWell(
                          onTap: () {
                            Get.toNamed('/sholatpuasa');
                          },
                          child: Container(
                            width: 160,
                            height: 92,
                            decoration: BoxDecoration(
                              color: Color(0xFFFFE7E7),
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
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 40,
                                ),
                                child: Text(
                                  'Hutang Puasa',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 545,
                right: 180,
                left: 0,
                child: Center(
                  child: Text(
                    'Informasi Terkait',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 585,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    Center(
                      child: informasiterkait(),
                    ),
                    SizedBox(height: 15), // Berikan jarak antara kedua widget
                    informasiterkait2(), // Tampilkan informasi kedua
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container informasiterkait() {
    return Container(
      width: 340,
      height: 42,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.error_outline,
            ),
          ),
          Text(
            _prayingDebtsCount == 0
                ? 'Anda tidak memiliki hutang sholat'
                : 'Anda memiliki $_prayingDebtsCount hutang sholat',
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Container informasiterkait2() {
    return Container(
      width: 340,
      height: 42,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.error_outline,
            ),
          ),
          Text(
            _fastingDebtsCount == 0
                ? 'Anda tidak memiliki hutang puasa'
                : 'Anda memiliki $_fastingDebtsCount hutang puasa',
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
//asli ini1