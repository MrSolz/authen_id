import 'package:authen_id/src/features/authentication/application/authentication_controller.dart';
import 'package:authen_id/src/features/home/domain/app_home.dart';
import 'package:authen_id/src/services/network/api.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeController extends StateNotifier<AppHome> {
  AuthenticationController? auth;
  final apiClient = ApiService();
  HomeController() : super(AppHome()) {
    getData();
  }
  Future getData() async {
    try {
      final response = await ApiService().get();
      state = AppHome.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response?.data);
        print(e.response?.headers);
        print(e.response?.requestOptions);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
      }
    }
  }

  void removeData() {
    state = AppHome();
  }
}

final homeProvider = StateNotifierProvider<HomeController, AppHome>((ref) {
  return HomeController();
});
