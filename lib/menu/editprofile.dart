import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:zenfemina_v2/shared/shared.dart';
import 'package:zenfemina_v2/widgets/color_extension.dart';
import 'package:zenfemina_v2/widgets/round_button.dart';
import 'package:zenfemina_v2/widgets/round_textfield.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zenfemina_v2/api_repository.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final ApiRepository _apiRepository = ApiRepository();
  final ImagePicker picker = ImagePicker();
  XFile? image;

  DateTime selectedDate = DateTime.now();
  TextEditingController txt_name = TextEditingController();
  TextEditingController txt_email = TextEditingController();
  TextEditingController txt_birthDate = TextEditingController();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    try {
      final userInfo = await _apiRepository.getUserInfo();
      final username = userInfo['data']['username'];
      final email = userInfo['data']['email'];
      final birthDate = userInfo['data']['birthDate'];

      setState(() {
        txt_name.text = username;
        txt_email.text = email;
        txt_birthDate.text = birthDate;
        _isLoading = false;
      });
    } catch (e) {
      print('Failed to load user info: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1970, 1),
      lastDate: DateTime.now(),
      helpText: 'Pilih tanggal lahir mu!',
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        txt_birthDate.text = DateFormat('yyyy-MM-dd').format(selectedDate);
      });
    }
  }

  Future<String> _uploadImage(XFile image) async {
    // Menggunakan package http untuk mengirimkan gambar ke server
    final url = Uri.parse(
        'http://v2.zenfemina.com/api/user/update'); // ini url nya nanti diganti buat upload foto
    final request = http.MultipartRequest('POST', url);
    request.files.add(await http.MultipartFile.fromPath('image', image.path));

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      final imageUrl = jsonDecode(response.body)['url'];
      return imageUrl;
    } else {
      throw Exception('Gagal mengunggah gambar: ${response.reasonPhrase}');
    }
  }

  Future<void> _updateProfile() async {
    final String username = txt_name.text;
    final String email = txt_email.text;
    final String birthDate = txt_birthDate.text;

    try {
      String? profileImgUrl;
      if (image != null) {
        // Jika gambar dipilih, unggah gambar ke server
        profileImgUrl = await _uploadImage(image!);
      }

      await _apiRepository.updateUser(
        username: username,
        email: email,
        profileImg: profileImgUrl ?? '',
        birthDate: birthDate,
      );
      // Tampilkan pesan sukses menggunakan snackbar
      Get.snackbar(
        'Sukses',
        'Data berhasil diperbarui',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      // Tampilkan pesan sukses atau lakukan tindakan lain yang sesuai
      print('Profil berhasil diperbarui');
    } catch (e) {
      // Tangani kesalahan saat pembaruan gagal
      print('Gagal memperbarui profil: $e');
      // Tampilkan pesan kesalahan kepada pengguna
      Get.snackbar(
        'Error',
        'Gagal memperbarui profil',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            size: 25,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        title: Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 10),
                    SizedBox(
                      height: 115,
                      width: 115,
                      child: Stack(
                        fit: StackFit.expand,
                        clipBehavior: Clip.none,
                        children: [
                          const SizedBox(height: 10),
                          Container(
                            width: 115,
                            height: 115,
                            decoration: BoxDecoration(
                              color: TColor.placeholder,
                              borderRadius: BorderRadius.circular(60),
                            ),
                            alignment: Alignment.center,
                            child: image != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(60),
                                    child: Image.file(
                                      File(image!.path),
                                      width: 115,
                                      height: 115,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Icon(
                                    Icons.person,
                                    size: 65,
                                    color: TColor.secondaryText,
                                  ),
                          ),
                          Positioned(
                            right: -16,
                            bottom: 0,
                            child: SizedBox(
                              height: 46,
                              width: 46,
                              child: TextButton(
                                onPressed: () async {
                                  image = await picker.pickImage(
                                      source: ImageSource.gallery);
                                  setState(() {});
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: const Color(0xFFF5F6F9),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    side: const BorderSide(color: Colors.black),
                                  ),
                                ),
                                child: SvgPicture.asset(
                                  "assets/images/cameraicon.svg",
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: EdgeInsets.only(top: 0, left: 30, right: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Form(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 25),
                                TextFormField(
                                  controller: txt_name,
                                  decoration: InputDecoration(
                                    labelText: "Username",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                            width: 2.0, color: Colors.grey)),
                                    prefixIcon: Icon(
                                      Icons.person_rounded,
                                      color: Colors.grey,
                                    ),
                                    labelStyle: GoogleFonts.outfit(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.grey,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                          width: 2.0, color: Colors.grey),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 15,
                                      horizontal: 20,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                TextFormField(
                                  controller: txt_email,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    labelText: "Email",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                            width: 2.0, color: Colors.grey)),
                                    prefixIcon: Icon(
                                      Icons.markunread_rounded,
                                      color: Colors.grey,
                                    ),
                                    labelStyle: GoogleFonts.outfit(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.grey,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                          width: 2.0, color: Colors.grey),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 15,
                                      horizontal: 20,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                TextFormField(
                                  controller: txt_birthDate,
                                  keyboardType: TextInputType.datetime,
                                  decoration: InputDecoration(
                                    labelText: "Tanggal Lahir",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                            width: 2.0, color: Colors.grey)),
                                    prefixIcon: IconButton(
                                      icon: Icon(Icons.calendar_month),
                                      onPressed: () {
                                        _selectDate(context);
                                      },
                                    ),
                                    labelStyle: GoogleFonts.outfit(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.grey,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                          width: 2.0, color: Colors.grey),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 15,
                                      horizontal: 20,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Container(
                                  height: 42,
                                  width: MediaQuery.of(context).size.width -
                                      2 * 20,
                                  child: ElevatedButton(
                                    onPressed: _updateProfile,
                                    child: Text(
                                      'Ubah',
                                      style: GoogleFonts.outfit(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFFDA4256),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
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
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
    );
  }
}
