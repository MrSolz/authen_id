import 'dart:async';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: constant_identifier_names
const BASE_URL = 'https://heracles.gobizdev.com/api';

class ApiService {
  late Dio client;
  final Completer _completer = Completer();
  ApiService() {
    client = Dio();

    client.options.connectTimeout = 5000;
    client.options.receiveTimeout = 30000;
    client.options.followRedirects = false;
    client.options.validateStatus = (status) {
      return status! < 500;
    };
  }

  void setToken(String authToken) {
    print("authToken $authToken");
    client.options.headers['Authorization'] = 'Bearer $authToken';
  }

  Future get() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? authToken = prefs.getString("token");
      client.options.headers['Authorization'] = 'Bearer $authToken';
      final response = await client.get("$BASE_URL/profile");
      _completer.complete(response);
    } catch (e) {
      _completer.completeError(e);
    }
    return _completer.future;
  }

  Future<void> clientSetup() async {
    final prefs = await SharedPreferences.getInstance();
    final String? authToken = prefs.getString("token");
    if (authToken!.isNotEmpty) client.options.headers['Authorization'] = 'Bearer $authToken';
  }
}
