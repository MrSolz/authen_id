import 'dart:async';

import 'package:authen_id/src/features/authentication/application/authentication_controller.dart';
import 'package:authen_id/src/features/home/application/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SignInLoadingController extends StateNotifier<AsyncValue<bool>> {
  SignInLoadingController() : super(const AsyncData(true));
  void setLoading(bool value) {
    state = AsyncData(value);
  }
}

FutureOr<NavigationDecision> navigationDelegate(
    NavigationRequest request, BuildContext context, WidgetRef ref) {
  var event = request.url.replaceAll("#", "?");
  final String? token = Uri.parse(event).queryParameters['access_token'];

  if (token != null && token.isNotEmpty) {
    ref.read(authRepositoryProvider.notifier).setToken(token);
    ref.read(homeProvider.notifier).getData();
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pop(context);
      // Prints after 1 second.
    });

    return NavigationDecision.prevent;
  }
  // print('allowing navigation to $request');
  return NavigationDecision.navigate;
}

final signInLoadingPageProvider =
    StateNotifierProvider.autoDispose<SignInLoadingController, AsyncValue<bool>>(
        (ref) => SignInLoadingController());
