import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:zenfemina_v2/api_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Tabsholatpuasa extends StatefulWidget {
  const Tabsholatpuasa({Key? key}) : super(key: key);

  @override
  _TabsholatpuasaState createState() => _TabsholatpuasaState();
}

class _TabsholatpuasaState extends State<Tabsholatpuasa> {
  final ApiRepository _apiRepository = ApiRepository();
  String? _details = '';
  String _date = '';
  bool subuhChecked = false;
  bool haidChecked = false;
  bool _isLoading = true;

  List<Map<String, dynamic>> _prayingDebts = [];
  List<Map<String, dynamic>> _completedPrayingDebts = [];
  List<Map<String, dynamic>> _completedFastingDebts = [];
  List<Map<String, dynamic>> _fastingDebts = [];

  @override
  void initState() {
    super.initState();
    _fetchPrayingDebts();
    _fetchFastingDebts();
    _loadCompletedDebts();
  }

  Future<void> _loadCompletedDebts() async {
    List<Map<String, dynamic>> completedPrayingDebts =
        await _getCompletedDebts('completedPrayingDebts');
    List<Map<String, dynamic>> completedFastingDebts =
        await _getCompletedDebts('completedFastingDebts');
    setState(() {
      _completedPrayingDebts = completedPrayingDebts;
      _completedFastingDebts = completedFastingDebts;
    });
  }

  Future<void> _updateDebtAndMove(int id, bool isSholat) async {
    try {
      if (isSholat) {
        await _apiRepository.updatePrayingDebt(id);
        setState(() {
          final debt = _prayingDebts.firstWhere((debt) => debt['id'] == id);
          _completedPrayingDebts.add(debt);
          _prayingDebts.removeWhere((debt) => debt['id'] == id);
        });
        _saveCompletedDebts(_completedPrayingDebts, 'completedPrayingDebts');
      } else {
        await _apiRepository.updateFastingDebt(id);
        setState(() {
          final debt = _fastingDebts.firstWhere((debt) => debt['id'] == id);
          _completedFastingDebts.add(debt);
          _fastingDebts.removeWhere((debt) => debt['id'] == id);
        });
        _saveCompletedDebts(_completedFastingDebts, 'completedFastingDebts');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchPrayingDebts() async {
    setState(() {
      _isLoading = true;
    });
    try {
      List<Map<String, dynamic>> debts = await _apiRepository.getPrayingDebts();
      if (debts.isNotEmpty) {
        setState(() {
          _prayingDebts = debts;
          _details = _prayingDebts[0]['details'];
          _date = _prayingDebts[0]['date'];
        });
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchFastingDebts() async {
    try {
      List<Map<String, dynamic>> debts = await _apiRepository.getFastingDebts();
      if (debts.isNotEmpty) {
        setState(() {
          _fastingDebts = debts;
          _details = _fastingDebts[0]['details'];
          _date = _fastingDebts[0]['date'];
        });
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _saveCompletedDebts(
      List<Map<String, dynamic>> completedDebts, String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> debtsJson =
        completedDebts.map((debt) => json.encode(debt)).toList();
    await prefs.setStringList(key, debtsJson);
  }

  Future<List<Map<String, dynamic>>> _getCompletedDebts(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? debtsJson = prefs.getStringList(key);
    if (debtsJson != null) {
      return debtsJson
          .map((debtJson) => json.decode(debtJson) as Map<String, dynamic>)
          .toList();
    }
    return [];
  }

  Future<void> _refreshData() async {
    await _fetchPrayingDebts();
    await _fetchFastingDebts();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.arrow_back),
                iconSize: 25,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Hutang shalat dan puasa',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          bottom: TabBar(
            indicatorColor: Color(0xFFDA4256),
            labelColor: Colors.black,
            tabs: [
              Tab(
                child: Text(
                  'Sholat',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'Puasa',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildPrayingDebtsTab(),
            _buildFastingDebtsTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildPrayingDebtsTab() {
    return Padding(
      padding: const EdgeInsets.only(top: 26),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: Column(
            children: [
              _buildTabBar(),
              Expanded(
                child: TabBarView(
                  children: [
                    _isLoading
                        ? Center(child: CircularProgressIndicator())
                        : RefreshIndicator(
                            onRefresh: _refreshData,
                            child: _buildSholatList(),
                          ),
                    _buildCompletedSholatList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFastingDebtsTab() {
    return Padding(
      padding: const EdgeInsets.only(top: 26),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: Column(
            children: [
              _buildTabBar(),
              Expanded(
                child: TabBarView(
                  children: [
                    _isLoading
                        ? Center(child: CircularProgressIndicator())
                        : RefreshIndicator(
                            onRefresh: _refreshData,
                            child: _buildPuasaList(),
                          ),
                    _buildCompletedFastingList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Color(0xFFDA4256).withOpacity(0.30),
      ),
      child: const TabBar(
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        indicator: BoxDecoration(
          color: Color(0xFFDA4256),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.black54,
        tabs: [
          Tab(text: 'Belum Lunas'),
          Tab(text: 'Lunas'),
        ],
      ),
    );
  }

  Widget _buildSholatCheckbox(String sholatName, bool isChecked,
      void Function(bool?) onChanged, int debtId, String date) {
    return GestureDetector(
      onTap: () {
        _showConfirmationDialog(
            isChecked, onChanged, debtId, 'Apakah anda sudah sholat?', true);
      },
      child: Container(
        height: 60,
        width: 330,
        margin: EdgeInsets.symmetric(vertical: 7, horizontal: 18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sholatName,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      date.isNotEmpty
                          ? DateFormat('yyyy.MM.dd')
                              .format(DateTime.parse(date))
                          : 'Tanggal tidak tersedia',
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              ),
            ),
            Checkbox(
              value: isChecked,
              onChanged: (bool? value) {
                _showConfirmationDialog(isChecked, onChanged, debtId,
                    'Apakah anda sudah sholat?', true);
              },
              shape: CircleBorder(),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              fillColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.selected)) {
                    return Colors.green;
                  }
                  return Colors.transparent;
                },
              ),
              checkColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSholatList() {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: ListView(
        children: _prayingDebts.isNotEmpty
            ? _prayingDebts.map((debt) {
                return _buildSholatCheckbox(
                  'Shalat ${debt['details']}',
                  subuhChecked,
                  (bool? value) {
                    setState(() {
                      subuhChecked = value ?? false;
                    });
                  },
                  debt['id'],
                  debt['date'],
                );
              }).toList()
            : [Center(child: Text('Tidak ada hutang shalat'))],
      ),
    );
  }

  Widget _buildCompletedSholatList() {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: ListView(
        children: _completedPrayingDebts.map((debt) {
          return _buildSholatCheckbox(
            'Sholat ${debt['details']}',
            true,
            (bool? value) {},
            debt['id'],
            debt['date'],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCompletedFastingList() {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: ListView(
        children: _completedFastingDebts.map((fast) {
          return _buildPuasaCheckbox(
            'Puasa ${fast['details']}',
            true,
            (bool? value) {},
            fast['id'],
            fast['date'],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPuasaList() {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: ListView(
        children: _fastingDebts.isNotEmpty
            ? _fastingDebts.map((fast) {
                return _buildPuasaCheckbox(
                  'Puasa ${fast['details']}',
                  haidChecked,
                  (bool? value) {
                    setState(() {
                      haidChecked = value ?? false;
                    });
                  },
                  fast['id'],
                  fast['date'],
                );
              }).toList()
            : [Center(child: Text('Tidak ada hutang puasa'))],
      ),
    );
  }

  void _showConfirmationDialog(bool isChecked, void Function(bool?) onChanged,
      int debtId, String message, bool isSholat) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          content: Container(
            width: 306,
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Text(
                  message,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 45),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          onChanged(true);
                        });
                        _updateDebtAndMove(debtId, isSholat);
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Color(0xFFDA4256),
                        backgroundColor: Colors.white,
                        side: BorderSide(color: Color(0xFFDA4256)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text(
                        'Sudah',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Color(0xFFDA4256),
                        side: BorderSide(color: Color(0xFFDA4256)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text(
                        'Belum',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPuasaCheckbox(String puasaName, bool isChecked,
      void Function(bool?) onChanged, int debtId, String date) {
    return GestureDetector(
      onTap: () {
        _showConfirmationDialog(isChecked, onChanged, debtId,
            'Apakah kamu sudah \n mengganti puasa?', false);
      },
      child: Container(
        height: 60,
        width: 330,
        margin: EdgeInsets.symmetric(vertical: 7, horizontal: 18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      puasaName,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      date.isNotEmpty
                          ? DateFormat('yyyy.MM.dd')
                              .format(DateTime.parse(date))
                          : 'Tanggal tidak tersedia',
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              ),
            ),
            Checkbox(
              value: isChecked,
              onChanged: (bool? value) {
                _showConfirmationDialog(isChecked, onChanged, debtId,
                    'Apakah kamu sudah \n mengganti puasa?', false);
              },
              shape: CircleBorder(),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              fillColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.selected)) {
                    return Colors.green;
                  }
                  return Colors.transparent;
                },
              ),
              checkColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
