import 'package:dio/dio.dart';
import 'package:flutter_application_2/models/popular_model.dart';

class ApiPopular {

  final URL = 'https://api.themoviedb.org/3/movie/popular?api_key=5019e68de7bc112f4e4337a500b96c56&language=es-MX&page=1';

  Future<List<PopularModel>> getPopularMovies() async {  // ← Ahora sí retorna una lista
  final dio = Dio();
  final response = await dio.get(URL);
  final res = response.data['results'] as List;

  return res.map((movie) => PopularModel.fromMap(movie)).toList();
  
  }
}

class ApiMovie {

  final Dio _dio = Dio();
  final URL = 'https://api.themoviedb.org/3';
  final String _apiKey = '5019e68de7bc112f4e4337a500b96c56';

  Future<String?> fetchTrailerKey(int movieId) async {
    final url = '$URL/movie/$movieId/videos?api_key=$_apiKey&language=es-MX';
    final response = await _dio.get(url);
    final results = response.data['results'] as List;

    final youtubeTrailer = results.firstWhere(
      (video) => video['site'] == 'YouTube' && video['type'] == 'Trailer',
      orElse: () => null,
    );

    return youtubeTrailer != null ? youtubeTrailer['key'] : null;
  }

  Future<List<Map<String, dynamic>>> fetchActors(int movieId) async {
    final url = '$_apiKey/movie/$movieId/credits?api_key=$_apiKey&language=es-MX';

    final response = await _dio.get(url);
    final cast = response.data['cast'] as List;

    return cast
        .where((actor) => actor['profile_path'] != null)
        .map((actor) => {
              'name': actor['name'],
              'profile_path': actor['profile_path'],
            })
        .toList();
  }
}