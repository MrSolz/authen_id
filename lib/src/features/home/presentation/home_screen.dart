import 'package:authen_id/src/features/authentication/presentation/log_out_screen.dart';
import 'package:authen_id/src/features/authentication/presentation/sign_in_screen.dart';
import 'package:authen_id/src/features/home/application/home_controller.dart';
import 'package:authen_id/src/utils/help.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeProvider);
    final String name = state.fullname ?? "";
    final String token = name;

    final ButtonStyle style = ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 14),
        padding: const EdgeInsets.only(left: 30, right: 30, top: 14, bottom: 14));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber.shade800,
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          RichText(
              text: TextSpan(
                  text: 'Chào mừng đến với ứng dụng ',
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                  children: [
                TextSpan(
                    text: FlutterConfig.get("APP_NAME"),
                    style: const TextStyle(
                        color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold))
              ])),
          token.isNotEmpty
              ? Column(
                  children: [
                    const SizedBox(height: 10),
                    RowText(value: state.fullname ?? "", label: "Họ và tên"),
                    const SizedBox(height: 10),
                    RowText(value: state.fullname ?? "", label: "Email"),
                    const SizedBox(height: 10),
                    RowText(value: state.phone ?? "", label: "Phone"),
                  ],
                )
              : const Text('Chưa đăng nhập'),
          const SizedBox(height: 30),
          ElevatedButton(
            style: style,
            onPressed: () {
              if (token.isNotEmpty) {
                Navigator.of(context).push(createRoute(const LogOutPage()));
              } else {
                Navigator.of(context).push(createRoute(const SignInPage()));
              }
            },
            child: Text(token.isNotEmpty ? 'Đăng xuất' : 'Đăng nhập'),
          ),
        ]),
      ),
    );
  }
}

class RowText extends StatelessWidget {
  const RowText({
    Key? key,
    required this.value,
    required this.label,
  }) : super(key: key);

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
            text: "$label: ",
            style: const TextStyle(color: Colors.black, fontSize: 14),
            children: [
          TextSpan(
              text: value,
              style:
                  const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold))
        ]));
  }
}
