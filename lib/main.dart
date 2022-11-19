import 'package:authen_id/src/app.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  // SharedPref.init();
  WidgetsFlutterBinding.ensureInitialized(); // Required by FlutterConfig
  await FlutterConfig.loadEnvVariables();
  runApp(ProviderScope(
      child: DevicePreview(
    enabled: false,
    // enabled: !kReleaseMode,
    builder: (context) => const MyApp(), // Wrap your app
  )));
}
