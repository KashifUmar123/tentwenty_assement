// ignore_for_file: use_build_context_synchronously
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:tentwenty_assement/data/response/api_response.dart';
import 'package:tentwenty_assement/model/genre_model.dart';
import 'package:tentwenty_assement/model/upcoming_movies_model.dart';
import 'package:tentwenty_assement/repository/genre/genre_repo.dart';
import 'package:tentwenty_assement/repository/genre/genre_repo_imp.dart';
import 'package:tentwenty_assement/repository/movie/movie_repo.dart';
import 'package:tentwenty_assement/repository/movie/movie_repo_imp.dart';
import 'package:tentwenty_assement/res/movie_search_status.dart';
import 'package:tentwenty_assement/utils/locator/locator.dart';
import 'package:tentwenty_assement/utils/nav_service.dart';

class MoviesViewModel extends ChangeNotifier {
  // data holders
  ApiResponse<UpcomingMovies> upcomingMovies = ApiResponse.loading();
  ApiResponse<GenresModel> genres = ApiResponse.loading();

  // current status of searching tracker
  ValueNotifier<MoiveSearchStatus> currentSearchStatus =
      ValueNotifier(MoiveSearchStatus.SearchNotCliecked);

  // getting repositories from service locator
  final MoviesRepo _moviesRepo = locator<MovieRepImp>();
  final GenreRepo _genresRepo = locator<GenreRepoImp>();
  // selected movie data
  Results? selectedResults;
  // trailer url (in this case it will be youtube id)
  String selectedTrailerUrl = "";

  setSelectedResults(Results results) {
    selectedResults = results;
    notifyListeners();
  }

  setSelectedTrailerUrl(String url) {
    selectedTrailerUrl = url;
    notifyListeners();
  }

  setUpcomingMovies(ApiResponse<UpcomingMovies> response) {
    upcomingMovies = response;
    notifyListeners();
  }

  setMovieSearchStatus(MoiveSearchStatus status) {
    currentSearchStatus.value = status;
    notifyListeners();
  }

  setGenres(ApiResponse<GenresModel> response) {
    genres = response;
    notifyListeners();
  }

  Future getTrailerUrl() async {
    try {
      var response = await _moviesRepo.getMovieTrailerUrl(selectedResults!.id);
      if (response != null) {
        setSelectedTrailerUrl(response);
      } else {
        ScaffoldMessenger.of(locator<NavService>().nav.context).showSnackBar(
          const SnackBar(
            content: Text("Not a valid url"),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(locator<NavService>().nav.context)
          .showSnackBar(SnackBar(
        content: Text(e.toString()),
        duration: const Duration(seconds: 3), // Adjust the duration as needed
      ));
      log(e.toString());
    }
  }

  Future fetchGenres() async {
    try {
      var response = await _genresRepo.getGenres();
      setGenres(ApiResponse.completed(response));
    } catch (e) {
      log(e.toString());
      setGenres(ApiResponse.error(e.toString()));
    }
  }

  Future fecthUpcomingMovies() async {
    try {
      log("fetching movies");
      var response = await _moviesRepo.getMovies();
      setUpcomingMovies(ApiResponse.completed(response));
    } catch (e) {
      log(e.toString());
      setUpcomingMovies(ApiResponse.error(e.toString()));
    }
  }
}
