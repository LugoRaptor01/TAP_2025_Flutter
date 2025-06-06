import 'package:dio/dio.dart';
import '../models/popular_model.dart';

class ApiPopular {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://api.themoviedb.org/3';
  final String _apiKey = '5019e68de7bc112f4e4337a500b96c56';
  final String _language = 'es-MX';

  // Obtener películas populares
  Future<List<PopularModel>> getPopularMovies() async {
    final url = '$_baseUrl/movie/popular?api_key=$_apiKey&language=$_language&page=1';
    final response = await _dio.get(url);
    final results = response.data['results'] as List;
    return results.map((movie) => PopularModel.fromMap(movie)).toList();
  }

  // Obtener trailer de una película
  Future<String?> fetchTrailerKey(int movieId) async {
    final url = '$_baseUrl/movie/$movieId/videos?api_key=$_apiKey&language=$_language';
    final response = await _dio.get(url);
    final results = response.data['results'] as List;

    final youtubeTrailer = results.firstWhere(
      (video) => video['site'] == 'YouTube' && video['type'] == 'Trailer',
      orElse: () => null,
    );

    return youtubeTrailer != null ? youtubeTrailer['key'] : null;
  }

  // Obtener actores de una película
  Future<List<Map<String, dynamic>>> fetchActors(int movieId) async {
    final url = '$_baseUrl/movie/$movieId/credits?api_key=$_apiKey&language=$_language';
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
