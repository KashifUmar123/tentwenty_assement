import 'package:flutter/material.dart';
import 'package:tentwenty_assement/utils/routes/route_names.dart';
import 'package:tentwenty_assement/utils/routes/undefined_route.dart';
import 'package:tentwenty_assement/view/detail/movie_details_view.dart';
import 'package:tentwenty_assement/view/detail/watch_trailer_view.dart';
import 'package:tentwenty_assement/view/home/home_view.dart';
import 'package:tentwenty_assement/view/seats/cinema_details_view.dart';
import 'package:tentwenty_assement/view/splash/splash_view.dart';

import '../../view/seats/select_seats_view.dart';

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

      case RoutesNames.movieDetails:
        return MaterialPageRoute(
          builder: (context) => const MoviesDetilsView(),
        );

      case RoutesNames.watchTrailer:
        var args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => WatchTrailerView(
            url: args["url"],
          ),
        );

      case RoutesNames.cinemaDetails:
        return MaterialPageRoute(
          builder: (context) => const CinemaDetailsView(),
        );

      case RoutesNames.cinemaSeats:
        return MaterialPageRoute(
          builder: (context) => const SelectSeatsScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => UndefinedView(name: settings.name),
          settings: settings,
        );
    }
  }
}
