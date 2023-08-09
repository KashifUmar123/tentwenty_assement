import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tentwenty_assement/data/response/api_response.dart';
import 'package:tentwenty_assement/model/upcoming_movies.dart';
import 'package:tentwenty_assement/repository/movie/movie_repo.dart';
import 'package:tentwenty_assement/repository/movie/movie_repo_imp.dart';
import 'package:tentwenty_assement/utils/locator/locator.dart';

class UpcomingMoviesViewModel extends ChangeNotifier {
  ApiResponse<UpcomingMovies> upcomingMovies = ApiResponse.loading();
  final MoviesRepo _moviesRepo = locator<MovieRepImp>();

  setUpcomingMovies(ApiResponse<UpcomingMovies> response) {
    upcomingMovies = response;
    notifyListeners();
  }

  Future fecthUpcomingMovies() async {
    try {
      var response = await _moviesRepo.getMovies();
      setUpcomingMovies(ApiResponse.completed(response));
    } catch (e) {
      log(e.toString());
      setUpcomingMovies(ApiResponse.error(e.toString()));
    }
  }

  Future fetchMovieDetails(int id) async {
    try {
      var response = await _moviesRepo.getMovieDetail(id);
    } catch (e) {
      log(e.toString());
    }
  }
}
