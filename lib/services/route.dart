import 'package:flutter/material.dart';
import 'package:pitaya_web/main.dart';
import 'package:pitaya_web/screens/auth/login.dart';
import 'package:pitaya_web/screens/auth/register.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/log':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/reg':
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case '/authCheck':
        return MaterialPageRoute(builder: (_) => const MainAuthPage());
      default:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
    }
  }
}
