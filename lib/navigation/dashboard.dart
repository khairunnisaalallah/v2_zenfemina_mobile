import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:zenfemina_v2/menu/calender.dart';
import 'package:zenfemina_v2/pages/home.dart';
import 'package:zenfemina_v2/widgets/circle_button.dart';
import 'package:zenfemina_v2/routes.dart';
import 'package:zenfemina_v2/api_repository.dart';
import 'package:intl/intl.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final ApiRepository _apiRepository = ApiRepository();
  String? _username = '';
  String _cycleStatus = 'beginCycle';

  String? condition = '';
  String? message = '';
  String? button = '';
  String? prayingDebtMsg = '';
  String? fastingDebtMsg = '';
  @override
  void initState() {
    super.initState();
    // _loadUserInfo();
    // _loadCycleData();
    _loadDebtsData();
    _loadCardView();
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

  Future<void> _loadCardView() async {
    try {
      final cardViews = await _apiRepository.getCardView();
      print(cardViews['data']['button']);

      setState(() {
        message = cardViews['data']['message'];
        condition = cardViews['data']['condition'];
        button = cardViews['data']['button'];
      });
    } catch (e) {
      print(e);
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
                  height: 250,
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
                left: 30,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 42),
                    Text(
                      'Hallo $_username',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Ayo mulai atur siklus haidmu !',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
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
                left: 22,
                right: 22,
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 185,
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
                            fontSize: 12,
                            color: Color(0XFFDA4256),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          // _calculateCycleDay(),
                          condition!,
                          style: GoogleFonts.poppins(
                            fontSize: 30,
                            color: Color(0xFFDA4256),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 0),
                        Text(
                          message!,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Color(0xFFDA4256),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: _updateCycle,
                          // (){} ,
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.white,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: BorderSide(
                                color: Color(0xFFDA4256),
                                width: 1,
                              ),
                            ),
                            minimumSize: Size(132, 35),
                          ),
                          child: Text(
                            // _getCycleButtonText(),
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
                top: 390,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.toNamed('/sholatpuasa');
                            },
                            child: Container(
                              width: 150,
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
                                      fontSize: 12,
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
                              width: 150,
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
                                      fontSize: 12,
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
                    )
                  ],
                ),
              ),
              Positioned(
                top: 505,
                right: 0,
                left: 20,
                child: Text(
                  'Informasi Terkait',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                top: 540,
                left: 20,
                right: 20,
                child: Column(
                  children: [
                    informasiterkait(),
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