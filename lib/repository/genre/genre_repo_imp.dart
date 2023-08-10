import 'dart:convert';
import 'dart:developer';

import 'package:tentwenty_assement/model/genre_model.dart';
import 'package:tentwenty_assement/repository/genre/genre_repo.dart';
import 'package:http/http.dart' as http;

import '../../data/apis/apis.dart';

class GenreRepoImp implements GenreRepo {
  @override
  Future getGenres() async {
    try {
      http.Response response = await Apis.get(
        url: "https://api.themoviedb.org/3/genre/movie/list?language=en",
        headers: {
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3MzQ1NzkzNGFmNTg1MDAzMzBmNDk4OWIwOWFkNDY5MSIsInN1YiI6IjY0ZDM4NGVmMDM3MjY0MDExYzA1NzI3MiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.gsMMvr_S_gfjuauDh-V-5QCRFxTMdCNRqaTxwS5zYOk',
          'accept': 'application/json',
        },
      );
      log(jsonDecode(response.body).toString());
      GenresModel genresModel = GenresModel.fromJson(jsonDecode(response.body));
      log("genre model done");

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
        url:
            "https://api.themoviedb.org/3/movie/$id/images?api_key=73457934af58500330f4989b09ad4691",
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
