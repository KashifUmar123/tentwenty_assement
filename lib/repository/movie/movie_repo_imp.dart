import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:tentwenty_assement/data/apis/apis.dart';
import 'package:tentwenty_assement/model/upcoming_movies.dart';
import 'package:tentwenty_assement/repository/movie/movie_repo.dart';

class MovieRepImp implements MoviesRepo {
  @override
  Future getMovies() async {
    try {
      http.Response resonse = await Apis.get(
        url: "https://api.themoviedb.org/3/movie/upcoming",
        headers: {
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3MzQ1NzkzNGFmNTg1MDAzMzBmNDk4OWIwOWFkNDY5MSIsInN1YiI6IjY0ZDM4NGVmMDM3MjY0MDExYzA1NzI3MiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.gsMMvr_S_gfjuauDh-V-5QCRFxTMdCNRqaTxwS5zYOk',
          'accept': 'application/json',
        },
      );

      return UpcomingMovies.fromJson(jsonDecode(resonse.body));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future getMovieDetail(int id) async {
    try {
      http.Response response = await Apis.get(
        url: "https://api.themoviedb.org/3/movie/$id",
        headers: {
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3MzQ1NzkzNGFmNTg1MDAzMzBmNDk4OWIwOWFkNDY5MSIsInN1YiI6IjY0ZDM4NGVmMDM3MjY0MDExYzA1NzI3MiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.gsMMvr_S_gfjuauDh-V-5QCRFxTMdCNRqaTxwS5zYOk',
          'accept': 'application/json',
        },
      );
      log(response.statusCode.toString());
      log(jsonDecode(response.body).toString());
    } catch (e) {
      rethrow;
    }
  }
}
