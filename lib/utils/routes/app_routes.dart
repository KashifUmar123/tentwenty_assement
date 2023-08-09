import 'package:flutter/material.dart';
import 'package:tentwenty_assement/utils/routes/route_names.dart';
import 'package:tentwenty_assement/utils/routes/undefined_route.dart';
import 'package:tentwenty_assement/view/home/home_view.dart';
import 'package:tentwenty_assement/view/splash/splash_view.dart';

class AppRoutes {
  AppRoutes._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesNames.splash:
        return MaterialPageRoute(
          builder: (context) => const SplashView(),
        );

      case RoutesNames.home:
        return MaterialPageRoute(
          builder: (context) => const HomeView(),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => UndefinedView(name: settings.name),
          settings: settings,
        );
    }
  }
}
