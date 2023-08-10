import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:tentwenty_assement/data/apis/apis.dart';
import 'package:tentwenty_assement/model/upcoming_movies_model.dart';
import 'package:tentwenty_assement/repository/movie/movie_repo.dart';

class MovieRepImp implements MoviesRepo {
  @override
  Future getMovies() async {
    try {
      http.Response response = await Apis.get(
        url:
            "https://api.themoviedb.org/3/movie/upcoming?api_key=73457934af58500330f4989b09ad4691",
        headers: {
          'accept': 'application/json',
        },
      );
      // log(jsonDecode(response.body).toString());

      return UpcomingMovies.fromJson(jsonDecode(response.body));
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

  @override
  Future getMovieTrailerUrl(int id) async {
    try {
      var response = await Apis.get(
        url:
            'https://api.themoviedb.org/3/movie/$id/videos?api_key=73457934af58500330f4989b09ad4691',
        headers: {
          'accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['results'];

        final trailers = results
            .where((eachVideo) => eachVideo['type'] == 'Trailer')
            .toList();

        if (trailers.isNotEmpty) {
          // return 'https://www.youtube.com/watch?v=${trailers[0]['key']}';
          return trailers[0]['key'];
        }

        return null;
      }
    } catch (e) {
      rethrow;
    }
  }
}
