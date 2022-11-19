import 'package:authen_id/src/features/authentication/presentation/log_out_screen.dart';
import 'package:authen_id/src/features/authentication/presentation/sign_in_screen.dart';
import 'package:authen_id/src/features/home/presentation/home_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  Routes._();

  //static variables
  static const String home = '/';
  static const String signIn = '/signIn';
  static const String logOut = '/logOut';

  static final routes = <String, WidgetBuilder>{
    home: (BuildContext context) => const HomeScreen(),
    signIn: (BuildContext context) => const SignInPage(),
    logOut: (BuildContext context) => const LogOutPage(),
  };
}
