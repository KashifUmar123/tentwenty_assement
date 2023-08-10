import 'dart:convert';
import 'dart:developer';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'package:tentwenty_assement/data/apis/apis.dart';
import 'package:tentwenty_assement/model/upcoming_movies_model.dart';
import 'package:tentwenty_assement/repository/movie/movie_repo.dart';
import 'package:tentwenty_assement/res/endpoints.dart';

class MovieRepImp implements MoviesRepo {
  String? apiKey = dotenv.env['API_KEY'];
  @override
  Future getMovies() async {
    try {
      http.Response response = await Apis.get(
        url: "${Endpoints.upcomingMovies}?api_key=${apiKey!}",
        headers: {
          'accept': 'application/json',
        },
      );

      return UpcomingMovies.fromJson(jsonDecode(response.body));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future getMovieDetail(int id) async {
    try {
      http.Response response = await Apis.get(
        url: "${Endpoints.movieDetails}/$id?api_key=${apiKey!}",
        headers: {
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
        url: '${Endpoints.movieDetails}/$id/videos?api_key=${apiKey!}',
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
          return trailers[0]['key'];
        }

        return null;
      }
    } catch (e) {
      rethrow;
    }
  }
}
