import 'dart:convert';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tentwenty_assement/model/genre_model.dart';
import 'package:tentwenty_assement/repository/genre/genre_repo.dart';
import 'package:http/http.dart' as http;
import 'package:tentwenty_assement/res/endpoints.dart';

import '../../data/apis/apis.dart';

class GenreRepoImp implements GenreRepo {
  String? apiKey = dotenv.env['API_KEY'];
  String? token = dotenv.env['TOKEN'];
  @override
  Future getGenres() async {
    try {
      http.Response response = await Apis.get(
        url: Endpoints.genres,
        headers: {
          'Authorization': 'Bearer $token',
          'accept': 'application/json',
        },
      );

      GenresModel genresModel = GenresModel.fromJson(jsonDecode(response.body));

      for (int i = 0; i < genresModel.genres.length; i++) {
        var imagePath = await getGenreCoverById(genresModel.genres[i].id);
        genresModel.genres[i].imagePath = imagePath;
      }

      return genresModel;
      //
    } catch (e) {
      rethrow;
    }
  }

  Future getGenreCoverById(int id) async {
    try {
      http.Response response = await Apis.get(
        url: "${Endpoints.movieDetails}/$id/images?api_key=${apiKey!}",
        headers: {
          'accept': 'application/json',
        },
      );
      var result = jsonDecode(response.body);

      if (response.statusCode == 404) {
        if (result["success"] == false) {
          return "";
        }
      }
      if (result['backdrops'].length == 0) {
        return "";
      }
      return "https://image.tmdb.org/t/p/w500${result['backdrops'][0]['file_path']}";
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
