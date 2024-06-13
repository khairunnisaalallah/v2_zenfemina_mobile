import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zenfemina_v2/menu/calender.dart';
import 'package:zenfemina_v2/pages/home.dart';
import 'package:zenfemina_v2/widgets/circle_button.dart';
import 'package:zenfemina_v2/routes.dart';
import 'package:zenfemina_v2/api_repository.dart';
import 'package:zenfemina_v2/navigation/pray.dart';
import 'package:zenfemina_v2/widgets/city_data.dart';
import 'package:zenfemina_v2/widgets/search_location.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final ApiRepository _apiRepository = ApiRepository();
  PrayPage _prayPage = PrayPage();
  String selectedCity = 'Jember';
  String? _username = '';
  String? _startDate = '';
  int _cycleLength = 0;
  int _periodLength = 0;
  int? _prayingDebtsCount = 0;
  int? _fastingDebtsCount = 0;
  // ? = bisa null atau nilai integer, klo ga pake berarti ga boleh null dan harus selalu punya nilai integer
  String _cycleStatus = 'beginCycle';
  bool _isLoading = true;
  String? _condition = '';
  String? _message = '';
  String? condition = '';
  String? message = '';
  String? button = '';
  String? prayingDebtMsg = '';
  String? fastingDebtMsg = '';

  @override
  void initState() {
    super.initState();
    _loadData();
    _loadSelectedCity();
  }

  Future<void> _loadSelectedCity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedCity = prefs.getString('selectedCity') ?? 'Jember';
    });
  }

  Future<void> _saveSelectedCity(String city) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedCity', city);
  }

  void onSelectCity(String newCity) {
    setState(() {
      selectedCity = newCity;
    });
    _saveSelectedCity(newCity);
  }

  // Future<void> _updatePrayerTimes() async {
  //   try {
  //     await _prayPage.fetchPrayerTimes(selectedCity);
  //   } catch (e) {
  //     print('Failed to update prayer times: $e');
  //   }
  // }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });

    await Future.wait([
      _loadUserInfo(),
      _loadCardview(),
      _loadDebtsData(),
      // _updatePrayerTimes()
    ]);
    setState(() {
      _isLoading = false;
    });
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

  Future<void> _loadCardview() async {
    try {
      final cardInfo = await _apiRepository.getCardView();
      final condition =
          cardInfo['data']['condition']; // Mengambil nilai condition
      setState(() {
        _condition = condition; // Menyimpan nilai condition ke dlm _condition
        final message = cardInfo['data']['message'];
        setState(() {
          _message = message;
        });
      });
    } catch (e) {
      print('Failed to load user info: $e');
    }
  }

  Future<void> _loadDebtsData() async {
    try {
      final prayingDebts = await _apiRepository.getPrayingDebtCount();
      final fastingDebts = await _apiRepository.getFastingDebtCount();
      // Tambahkan logging untuk data yang diterima dari API
      print(prayingDebts['data']['message']);
      print(fastingDebts['data']['message']);
      setState(() {
        prayingDebtMsg = prayingDebts['data']['message'];
        fastingDebtMsg = fastingDebts['data']['message'];
      });
    } catch (e) {
      print('Failed to load debts data: $e');
    }
  }

  Future<void> _updateCycle() async {
    // print(button);
    // if (button == 'Awali Siklus') {
    //     print('bener');
    // } else {
    //   print('salah');
    // }
    try {
      if (button == 'Awali Siklus') {
        // print('bener');
        _beginCycle();

        // await _apiRepository.beginCycle();
        // setState(() {
        //   _cycleStatus = 'continueCycle';
        // });
      } else {
        // _endCycle();

        // await _apiRepository.continueCycle();
        // setState(() {
        //   _cycleStatus = 'endCycle';
        // });
      }
    } catch (e) {
      print('Failed to update cycle status: $e');
    }
  }

  Future<void> _beginCycle() async {
    DateTime now = DateTime.now();
    Get.defaultDialog(
      title: "Konfirmasi",
      middleText: "Apakah Anda sudah haid?",
      actions: [
        ElevatedButton(
          onPressed: () {
            Get.back();
          },
          child: Text("Belum"),
        ),
        ElevatedButton(
          onPressed: () async {
            await _apiRepository.beginCycle(
                inputDate: DateFormat('d-m-Y').format(now));
            Get.back();
            Get.offAll(Home());
          },
          child: Text("Sudah"),
        ),
      ],
    );
  }

  Future<void> _endCycle() async {
    Get.defaultDialog(
      title: "Konfirmasi",
      middleText: "Apakah Anda masih Haid?",
      actions: [
        ElevatedButton(
          onPressed: () async {
            await _apiRepository.endCycle();
            Get.back();
            Get.offAll(Home());
          },
          child: Text("Tidak"),
        ),
        ElevatedButton(
          onPressed: () async {
            await _apiRepository.continueCycle();
            Get.back();
            Get.offAll(Home());
          },
          child: Text("Iya"),
        ),
      ],
    );
  }

  // String _getCycleButtonText() {
  //   switch (_cycleStatus) {
  //     case 'beginCycle':
  //       return 'Mulai Siklus';
  //     case 'continueCycle':
  //       return 'Lanjutkan Siklus';
  //     case 'endCycle':
  //       return 'Siklus Berakhir';
  //     default:
  //       return 'Mulai Siklus';
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final currentDate = DateTime.now(); // Ambil tanggal terbaru saat build
    return Scaffold(
      backgroundColor: Colors.white,
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(), // Display loading indicator
            )
          : RefreshIndicator(
              onRefresh: _loadData,
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
                        top: 55,
                        right: 40,
                        left: 30,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 160, // Menyesuaikan lebar
                              height: 37, // Menyesuaikan tinggi
                              child: buildLocationSearch(
                                selectedCity,
                                cities,
                                onSelectCity,
                              ),
                            ),
                            SizedBox(height: 20),
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
                                Get.to(() => CalenderPage());
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
                        top: 190,
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
                                  DateFormat('dd MMMM yyyy')
                                      .format(currentDate),
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: Color(0XFFDA4256),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  _condition ?? '',
                                  style: GoogleFonts.poppins(
                                    fontSize: 32,
                                    color: Color(0xFFDA4256),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  _message ?? '',
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    color: Color(0xFFDA4256),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: _updateCycle,
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
                                    //_getCycleButtonText(),
                                    button!,
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
                        top: 400,
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
                            SizedBox(
                                height:
                                    15), // Berikan jarak antara kedua widget
                            informasiterkait2(), // Tampilkan informasi kedua
                          ],
                        ),
                      ),
                    ],
                  ),
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
              color: Colors.red,
              size: 22,
            ),
          ),
          Text(
            '$prayingDebtMsg sholat',
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
              color: Colors.red,
              size: 22,
            ),
          ),
          Text(
            '$fastingDebtMsg puasa',
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