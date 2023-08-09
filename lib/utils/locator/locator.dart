import 'package:get_it/get_it.dart';
import 'package:tentwenty_assement/repository/movie/movie_repo_imp.dart';
import '../nav_service.dart';

final locator = GetIt.instance;

setupLocator() {
  locator.registerLazySingleton(() => NavService());
  locator.registerLazySingleton(() => MovieRepImp());
}
