import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/network/api_popular.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:flutter_application_2/models/popular_model.dart';

class DetailedPopularMovie extends StatefulWidget {
  const DetailedPopularMovie({super.key});

  @override
  State<DetailedPopularMovie> createState() => _DetailedPopularMovieState();
}

class _DetailedPopularMovieState extends State<DetailedPopularMovie> {

  late YoutubePlayerController _ytController;
  late Future<String?> _trailerFuture;
  late PopularModel popular; 
  late Future<List<Map<String, dynamic>>> _actorsFuture;
  
  final ApiPopular _apiPopular = ApiPopular();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    popular = ModalRoute.of(context)!.settings.arguments as PopularModel;

    _trailerFuture = _apiPopular.fetchTrailerKey(popular.id);
    _actorsFuture = _apiPopular.fetchActors(popular.id);
  }

  @override
  void dispose() {
    _ytController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final popular = ModalRoute.of(context)!.settings.arguments as PopularModel;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: screenHeight * 0.4,
            stretch: true,
            pinned: true,
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                return FlexibleSpaceBar(
                  centerTitle: true,
                  title: Hero(
                    tag: 'title-${popular.id}',
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Stack(
                          children: [
                            // Efecto de borde
                            Text(
                              popular.title,
                              style: TextStyle(
                                fontSize: 16,
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 3
                                  ..color = Colors.black,
                              ),
                            ),
                            // Texto principal
                            Text(
                              popular.title,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Imagen de fondo.
                      CachedNetworkImage(
                        imageUrl: popular.backdropPath,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(color: Colors.grey[900]),
                        errorWidget: (context, url, error) => Container(
                          color: Colors.grey[900],
                          child: const Icon(Icons.error, color: Color.fromARGB(255, 68, 67, 67)),
                        ),
                      ),
                      
                      DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.3),
                              Colors.black.withOpacity(0.7),
                              Colors.black,
                            ],
                            stops: const [0.0, 0.3, 0.7, 1.0],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Reproductor de YouTube
                  FutureBuilder<String?>(
                    future: _trailerFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return _buildPlaceholder();
                      } else if (snapshot.hasError || snapshot.data == null) {
                        return _buildError();
                      } else {
                        
                        _ytController = YoutubePlayerController.fromVideoId(
                          videoId: snapshot.data!,
                          autoPlay: false,
                          params: const YoutubePlayerParams(
                            showFullscreenButton: true,
                            showVideoAnnotations: false,
                          ),
                        );

                        return _buildYoutubePlayer();
                      }
                    },
                  ),

                  const SizedBox(height: 16),

                  // Información general
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Póster de la película
                        Hero(
                          tag: 'poster-${popular.id}',
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              imageUrl: popular.posterPath.startsWith('http')
                                  ? popular.posterPath
                                  : 'https://image.tmdb.org/t/p/w500${popular.posterPath}',
                              width: 120, // Aumenté un poco el tamaño
                              height: 180,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                width: 120,
                                height: 180,
                                color: Colors.grey[900],
                                child: const Center(child: CircularProgressIndicator()),
                              ),
                              errorWidget: (context, url, error) => Container(
                                width: 120,
                                height: 180,
                                color: Colors.grey[900],
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.error_outline, color: Colors.red, size: 40),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Error al cargar',
                                      style: TextStyle(color: Colors.white, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 16),

                        // Información de la película
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                popular.title,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${popular.releaseDate} • ${popular.originalLanguage.toUpperCase()}',
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  RatingBarIndicator(
                                    rating: popular.voteAverage / 2,
                                    itemBuilder: (context, index) =>
                                        const Icon(Icons.star, color: Colors.amber),
                                    itemCount: 5,
                                    itemSize: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '${popular.voteAverage.toStringAsFixed(1)}/10',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${popular.voteCount} votos',
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Sinopsis
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Sinopsis',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          popular.overview,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Reparto
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Reparto',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                          SizedBox(
                            height: 150,
                            child: FutureBuilder<List<Map<String, dynamic>>>(
                            future: _actorsFuture,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const Center(child: CircularProgressIndicator());
                              } else if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
                                return const Center(
                                  child: Text(
                                    'No se pudo cargar el reparto.',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                );
                              } else {
                                final actors = snapshot.data!;
                                return SizedBox(
                                  height: 150,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: actors.length.clamp(0, 10),
                                    itemBuilder: (context, index) {
                                      final actor = actors[index];
                                      return Padding(
                                        padding: const EdgeInsets.only(right: 12.0),
                                        child: Column(
                                          children: [
                                            CircleAvatar(
                                              radius: 40,
                                              backgroundImage: CachedNetworkImageProvider(
                                                'https://image.tmdb.org/t/p/w200${actor['profile_path']}',
                                              ),
                                              backgroundColor: Colors.grey[900],
                                            ),
                                            const SizedBox(height: 8),
                                            SizedBox(
                                              width: 80,
                                              child: Text(
                                                actor['name'],
                                                style: const TextStyle(color: Colors.white),
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholder() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildError() {
    return const Center(
      child: Icon(Icons.error_outline, color: Colors.red),
    );
  }

  Widget _buildYoutubePlayer() {
    return YoutubePlayerScaffold(
      controller: _ytController,
      aspectRatio: 16 / 9,
      builder: (context, player) => player,
    );
  }
}