import 'dart:async';

import 'package:authen_id/src/features/authentication/application/authentication_controller.dart';
import 'package:authen_id/src/features/home/application/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LogOutLoadingController extends StateNotifier<AsyncValue<bool>> {
  LogOutLoadingController() : super(const AsyncData(true));
  void setLoading(bool value) {
    state = AsyncData(value);
  }
}

FutureOr<NavigationDecision> navigationDelegate(
    NavigationRequest request, BuildContext context, WidgetRef ref) {
  final bool check = request.url.contains("/login");

  if (check) {
    print('blocking navigation to $request');
    ref.read(homeProvider.notifier).removeData();
    ref.read(authRepositoryProvider.notifier).removeToken();
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pop(context);
      // Prints after 1 second.
    });
    return NavigationDecision.prevent;
  }
  print('allowing navigation to $request');
  return NavigationDecision.navigate;
}

void onPageFinished(ref) {
  ref.read(logOutLoadingPageProvider.notifier).setLoading(false);
}

final logOutLoadingPageProvider =
    StateNotifierProvider.autoDispose<LogOutLoadingController, AsyncValue<bool>>(
        (ref) => LogOutLoadingController());
