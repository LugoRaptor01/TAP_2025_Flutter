class PopularModel {
  String backdropPath;
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  String releaseDate;
  String title;
  double voteAverage;
  int voteCount;

  PopularModel({
    required this.backdropPath,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
  }); //las llaves en el método, indican que los parámetros son nombrados y no posicionales.


  factory PopularModel.fromMap(Map<String, dynamic> movie) {

    return PopularModel(
      backdropPath: 'https://image.tmdb.org/t/p/w500/${movie['backdrop_path'] ?? ''}',
      id: movie['id'],
      originalLanguage: movie['original_language'],
      originalTitle: movie['original_title'],
      overview: movie['overview'],
      popularity: movie['popularity'],
      posterPath: movie['poster_path'] != null 
          ? 'https://image.tmdb.org/t/p/w500${movie['poster_path']}'
          : 'https://via.placeholder.com/500x750?text=No+Poster', // Imagen alternativa
      releaseDate: movie['release_date'],
      title: movie['title'],
      voteAverage: (movie['vote_average'] as num).toDouble(),
      voteCount: movie['vote_count'],
    );
  }
}