import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zenfemina_v2/pages/home.dart';
import 'package:zenfemina_v2/pages/question1.dart';
import 'package:zenfemina_v2/api_repository.dart';
import 'package:zenfemina_v2/service/fcm_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isPasswordVisible = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late ApiRepository _apiRepository;
  bool _isLoading = false;

  final FcmService _fcmService = FcmService();

  @override
  void initState() {
    super.initState();
    _apiRepository = ApiRepository();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDA4256),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            size: 25,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top -
              AppBar().preferredSize.height,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFFDA4256),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 0, left: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Masuk',
                      style: GoogleFonts.poppins(
                        fontSize: 32,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0, left: 0),
                      child: Text(
                        'Masuk ke akunmu, dan mulai atur jadwal \nsiklusmu dari sekarang!',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                  child: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: "Email",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon: Icon(
                              Icons.mail,
                              color: Colors.grey,
                            ),
                            labelStyle: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                              color: Colors.grey,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  BorderSide(width: 2.0, color: Colors.grey),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 20,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: passwordController,
                          obscureText: !_isPasswordVisible,
                          decoration: InputDecoration(
                            labelText: "Kata Sandi",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.grey,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                            ),
                            labelStyle: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                              color: Colors.grey,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  BorderSide(width: 2.0, color: Colors.grey),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 20,
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Lupa Kata Sandi?",
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        SizedBox(height: 80),
                        Container(
                          height: 42,
                          width: MediaQuery.of(context).size.width - 2 * 20,
                          child: ElevatedButton(
                            onPressed: _isLoading
                                ? null
                                : () async {
                                    final email = emailController.text;
                                    final password = passwordController.text;

                                    if (email.isEmpty && password.isEmpty) {
                                      Get.snackbar(
                                        'Error',
                                        'Mohon isi data berikut',
                                        backgroundColor: Colors.red,
                                        colorText: Colors.white,
                                      );
                                    } else if (email.isEmpty) {
                                      Get.snackbar(
                                        'Error',
                                        'Mohon isi kolom email terlebih dahulu',
                                        backgroundColor: Colors.red,
                                        colorText: Colors.white,
                                      );
                                    } else if (password.isEmpty) {
                                      Get.snackbar(
                                        'Error',
                                        'Mohon isi kolom password terlebih dahulu',
                                        backgroundColor: Colors.red,
                                        colorText: Colors.white,
                                      );
                                    } else {
                                      setState(() {
                                        _isLoading = true;
                                      });
                                      try {
                                        final result =
                                            await _apiRepository.loginUser(
                                          emailController.text,
                                          passwordController.text,
                                        );

                                        print('API Response: $result');

                                        setState(() {
                                          _isLoading = false;
                                        });

                                        if (result['meta']['code'] == 200) {
                                          final userData = result['data'];

                                          if (userData['birthDate'] == null ||
                                              userData['birthDate'].isEmpty) {
                                            Get.snackbar(
                                              'Informasi',
                                              'Selamat datang, pengguna baru! Silakan isi pertanyaan pertama.',
                                              backgroundColor: Colors.green,
                                              colorText: Colors.white,
                                            );
                                            Get.to(() => Question1Page());
                                          } else {
                                            final prefs =
                                                await SharedPreferences
                                                    .getInstance();
                                            final token = userData['token'];

                                            _fcmService.initializeFCM(token);

                                            if (token != null) {
                                              await prefs.setString(
                                                  'token', token);

                                              Get.snackbar(
                                                'Sukses',
                                                'Berhasil masuk!',
                                                backgroundColor: Colors.green,
                                                colorText: Colors.white,
                                              );
                                              Get.offAll(() => Home());
                                            } else {
                                              throw Exception('Token is null');
                                            }
                                          }
                                        } else {
                                          final errorMessage =
                                              result['errors'][0];
                                          Get.snackbar(
                                            'Error',
                                            errorMessage,
                                            backgroundColor: Colors.red,
                                            colorText: Colors.white,
                                          );
                                        }
                                      } catch (e) {
                                        setState(() {
                                          _isLoading = false;
                                        });
                                        print('Error: $e');
                                        Get.snackbar(
                                          'Error',
                                          'Email atau Kata Sandi salah.',
                                          backgroundColor: Colors.red,
                                          colorText: Colors.white,
                                        );
                                      }
                                    }
                                  },
                            child: _isLoading
                                ? CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  )
                                : Text(
                                    'Masuk',
                                    style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFDA4256),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
