import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tentwenty_assement/utils/locator/locator.dart';
import 'package:tentwenty_assement/utils/nav_service.dart';
import 'package:tentwenty_assement/utils/routes/app_routes.dart';
import 'package:tentwenty_assement/utils/routes/route_names.dart';
import 'package:tentwenty_assement/utils/theme/app_theme.dart';
import 'package:tentwenty_assement/view_model/upcoming_movies_view_model.dart';

void main() {
  setupLocator();
  runApp(const TenTwentyApp());
}

class TenTwentyApp extends StatelessWidget {
  const TenTwentyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(375, 812),
    );
    final NavService navigationService = locator<NavService>();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UpcomingMoviesViewModel(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigationService.rootNavKey,
        onGenerateRoute: AppRoutes.generateRoute,
        initialRoute: RoutesNames.home,
        theme: AppTheme.theme,
      ),
    );
  }
}
