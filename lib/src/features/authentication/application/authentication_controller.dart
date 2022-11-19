import 'package:authen_id/src/services/network/api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationController extends StateNotifier<AsyncValue<String>> {
  AuthenticationController() : super(const AsyncData("")) {
    getToken();
  }
  Future getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString("token");
    print("token $token");
    state = AsyncData(token ?? "");
  }

  Future setToken(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', value);
    ApiService().setToken(value);
    state = AsyncData(value);
  }

  Future removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("token");
    state = const AsyncData("");
  }
}

final authRepositoryProvider = StateNotifierProvider<AuthenticationController, AsyncValue>((ref) {
  return AuthenticationController();
});
