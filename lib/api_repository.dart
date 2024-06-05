import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiRepository {
  Future<Map<String, dynamic>> registerUser(
      String username, String email, String password) async {
    final response = await http.post(
      Uri.parse('http://v2.zenfemina.com/api/user/register'),
      body: jsonEncode(<String, String>{
        'username': username,
        'email': email,
        'password': password,
      }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to register user: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> loginUser(String email, String password) async {
    final response = await http.post(
      Uri.parse('http://v2.zenfemina.com/api/user/login'),
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    // Log untuk respons mentah dari server
    print('Raw API Response: ${response.body}');

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      final token = result['data']['token']; // Ambil token dari data

      // Log untuk memastikan token tidak null
      print('Token: $token');
      // Save the token in shared preferences jika token tidak null
      if (token != null) {
        final prefs = await SharedPreferences.getInstance();
        final success = await prefs.setString(
            'token', token); // Simpan token ke SharedPreferences

        if (success) {
          print('Token berhasil disimpan di SharedPreferences.');
        } else {
          print('Gagal menyimpan token di SharedPreferences.');
        }
      } else {
        throw Exception('Token is null');
      }
      return result;
    } else {
      throw Exception('Failed to login: ${response.body}');
    }
  }

  Future<void> postQuestions(
      String birthDate, String lastDate, String period, String cycle, String is_holy) async {
    final url = Uri.parse('http://v2.zenfemina.com/api/home/question');

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    print('Token in postQuestions: $token');

    // Periksa apakah token valid sebelum mengirim permintaan
    if (token.isEmpty) {
      throw Exception('Token is empty');
    }

    final Map<String, String> data = {
      'birthDate': birthDate,
      'lastDate': lastDate,
      'period': period,
      'cycle': cycle,
      'is_holy': is_holy
    };

    // Log the data being sent
    print('Data being sent: $data');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': token,
      },
      body: jsonEncode({
        'birthDate': birthDate,
        'lastDate': lastDate,
        'period': period,
        'cycle': cycle,
        'is_holy': is_holy
      }),
    );

    print('Request Headers: ${response.request?.headers}');
    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      print('Questions Posted Successfully');
    } else {
      print('Failed to post questions: ${response.body}');
      throw Exception('Failed to post questions: ${response.body}');
    }
  }

  Future<void> logoutUser() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token != null) {
      final response = await http.post(
        Uri.parse('http://v2.zenfemina.com/api/user/logOut'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': token,
        },
      );

      if (response.statusCode == 200) {
        // Hapus token dari SharedPreferences
        await prefs.remove('token');
        print('Logout berhasil');
      } else {
        throw Exception('Gagal melakukan logout: ${response.body}');
      }
    } else {
      throw Exception('Token tidak ditemukan');
    }
  }

  Future<Map<String, dynamic>> getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token != null) {
      final response = await http.get(
        Uri.parse('http://v2.zenfemina.com/api/user/current'),
        headers: {
          'Authorization': token,
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to get user info: ${response.body}');
      }
    } else {
      throw Exception('Token is null');
    }
  }

  Future<Map<String, dynamic>> getCycleData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token != null && token.isNotEmpty) {
      final response = await http.get(
        Uri.parse('http://v2.zenfemina.com/api/home/getCycle?type=hist'),
        headers: {
          'Authorization': token,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (data.containsKey('data') && data['data'] is Map<String, dynamic>) {
          return data;
        } else {
          throw Exception('Unexpected response structure: ${response.body}');
        }
      } else {
        throw Exception('Failed to get cycle data: ${response.body}');
      }
    } else {
      throw Exception('Token is null or empty');
    }
  }

  final String baseUrl = 'http://v2.zenfemina.com/api/cycle';

  Future<void> beginCycle() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token != null && token.isNotEmpty) {
      final response = await http.post(
        Uri.parse('$baseUrl/beginCycle'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
      );
      print('Request URL: ${response.request?.url}');
      print('Request Headers: ${response.request?.headers}');
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
      if (response.statusCode == 200) {
        print('Begin cycle successful');
      } else {
        throw Exception('Failed to begin cycle: ${response.body}');
      }
    } else {
      throw Exception('Token is null or empty');
    }
  }

  Future<void> continueCycle() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token != null && token.isNotEmpty) {
      final response = await http.post(
        Uri.parse('$baseUrl/continueCycle'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
      );
      print('Request URL: ${response.request?.url}');
      print('Request Headers: ${response.request?.headers}');
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
      if (response.statusCode == 200) {
        print('Continue cycle successful');
      } else {
        throw Exception('Failed to continue cycle: ${response.body}');
      }
    } else {
      throw Exception('Token is null or empty');
    }
  }

  Future<void> endCycle() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token != null && token.isNotEmpty) {
      final response = await http.post(
        Uri.parse('$baseUrl/endCycle'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
      );
      print('Request URL: ${response.request?.url}');
      print('Request Headers: ${response.request?.headers}');
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
      if (response.statusCode == 200) {
        print('End cycle successful');
      } else {
        throw Exception('Failed to end cycle: ${response.body}');
      }
    } else {
      throw Exception('Token is null or empty');
    }
  }

  Future<Map<String, dynamic>> updateUser({
    required String username,
    required String email,
    required String profileImg,
    required String birthDate,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token != null && token.isNotEmpty) {
      final response = await http.post(
        Uri.parse('http://v2.zenfemina.com/api/user/update'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': token,
        },
        body: jsonEncode({
          'username': username,
          'email': email,
          'profile_img': profileImg,
          'birthDate': birthDate,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to update user: ${response.body}');
      }
    } else {
      throw Exception('Token is null or empty');
    }
  }

  // Fungsi untuk mengambil semua artikel
  Future<List<dynamic>> getArticles() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token != null) {
      final response = await http.get(
        Uri.parse('http://v2.zenfemina.com/api/education/all'),
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final List<dynamic> articles = responseData['data'];
        return articles;
      } else {
        throw Exception('Failed to load articles: ${response.body}');
      }
    } else {
      throw Exception('Token is null');
    }
  }

  final String baseUrldebt = 'http://v2.zenfemina.com/api/debt/get';

  Future<List<Map<String, dynamic>>> getPrayingDebts() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token != null) {
        final response = await http.get(
          Uri.parse('$baseUrldebt?type=praying&is_done=0'),
          headers: {
            'Authorization': token,
            'Content-Type': 'application/json',
          },
        );

        if (response.statusCode == 200) {
          final parsedResponse = jsonDecode(response.body);
          final List<dynamic> data = parsedResponse['data'];

          return List<Map<String, dynamic>>.from(data);
        } else {
          throw Exception('Failed to load praying debts: ${response.body}');
        }
      } else {
        throw Exception('Token is null');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getFastingDebts() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token != null) {
        final response = await http.get(
          Uri.parse('$baseUrldebt?type=fasting&is_done=0'),
          headers: {
            'Authorization': token,
            'Content-Type': 'application/json',
          },
        );

        if (response.statusCode == 200) {
          final parsedResponse = jsonDecode(response.body);
          final List<dynamic> data = parsedResponse['data'];

          return List<Map<String, dynamic>>.from(data);
        } else {
          throw Exception('Failed to load fasting debts: ${response.body}');
        }
      } else {
        throw Exception('Token is null');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<void> updatePrayingDebt(int debtId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token != null) {
        final response = await http.post(
          Uri.parse("http://v2.zenfemina.com/api/debt/update"),
          headers: {
            'Authorization': token,
            'Content-Type': 'application/json',
          },
          body: jsonEncode({'id': debtId}),
        );

        if (response.statusCode != 200) {
          throw Exception('Failed to update praying debt: ${response.body}');
        }
      } else {
        throw Exception('Token is null');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  //   Future<List<Map<String, dynamic>>> getDebts(String type) async {
  //   try {
  //     final prefs = await SharedPreferences.getInstance();
  //     final token = prefs.getString('token');

  //     if (token != null) {
  //       final response = await http.get(
  //         Uri.parse('$baseUrldebt?type=$type&is_done=0'),
  //         headers: {
  //           'Authorization': token,
  //           'Content-Type': 'application/json',
  //         },
  //       );

  //       if (response.statusCode == 200) {
  //         final parsedResponse = jsonDecode(response.body);
  //         final List<dynamic> data = parsedResponse['data'];

  //         return List<Map<String, dynamic>>.from(data);
  //       } else {
  //         throw Exception('Failed to load debts: ${response.body}');
  //       }
  //     } else {
  //       throw Exception('Token is null');
  //     }
  //   } catch (e) {
  //     throw Exception('Error: $e');
  //   }
  // }
}
//ini asli rill