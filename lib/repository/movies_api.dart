import 'package:app_test/models/movies_model.dart';
import 'package:app_test/models/movies_detail_model.dart';
import 'package:dio/dio.dart';

class MoviesApi {
  final String baseUrl =
      "https://desafio-mobile.nyc3.digitaloceanspaces.com/movies-v2";

  Future<List<Movies>> getListMovies() async {
    Response response = await Dio().get(baseUrl);

    if (response.statusCode == 200) {
      var listMovies = (response.data as List).map((e) {
        return Movies.fromJson(e);
      }).toList();
      return listMovies;
    } else {
      throw "Error";
    }
  }

  Future<MoviesDetail> getMoviesDetail(String id) async {
    Response response = await Dio().get("$baseUrl/$id");

    if (response.statusCode == 200) {
      return MoviesDetail.fromJson(response.data);
    } else {
      throw "Error";
    }
  }
}
