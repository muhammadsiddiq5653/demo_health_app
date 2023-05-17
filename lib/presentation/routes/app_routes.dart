import 'package:authentication_riverpod/presentation/Pages/auth/login/login_page.dart';
import 'package:flutter/cupertino.dart';

import '../export.dart';
import 'export.dart';

class AppRoutes {
  static const String loginPage = '/loginPage';
  static const String healthDataScreen = '/healthDataScreen';

  static Route<dynamic> appRoutes(final RouteSettings settings) {
    switch (settings.name) {
      case loginPage:
        return platformRoute(
          child: const LoginPage(),
          settings: settings,
        );
      case healthDataScreen:
        return platformRoute(
          child: const HealthDataScreen(),
          settings: settings,
        );

      default:
        throw UnimplementedError('Route is not implemented!');
    }
  }
}
