import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FcmService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initializeFCM(String token) async {
    await _getTokenAndUpdateServer(token);
    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
      _sendTokenToServer(fcmToken, token);
    });
  }

  Future<void> _getTokenAndUpdateServer(token) async {
    String? fcmToken = await _firebaseMessaging.getToken();
    if (fcmToken != null) {
      await _sendTokenToServer(fcmToken, token);
    }
  }

  Future<void> _sendTokenToServer(String fcmToken, String token) async {
    final response = await http.post(
      Uri.parse('http://v2.zenfemina.com/api/user/update'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': token,
      },
      body: jsonEncode({'fcm_token': fcmToken}),
    );

    if (response.statusCode == 200) {
      print('Token sent successfully');
    } else {
      print('Failed to send token');
    }
  }
}
