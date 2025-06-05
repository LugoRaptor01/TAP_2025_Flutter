import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    // Inicializa el controlador de YouTube con un video de ejemplo
    _ytController = YoutubePlayerController(
      params: const YoutubePlayerParams(
        showControls: true,
        mute: false,
        showFullscreenButton: true,
        loop: false,
      ),
    )..loadVideoById(videoId: 'dQw4w9WgXcQ'); // ID de video de ejemplo
  }

  @override
  void dispose() {
    _ytController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final popular = ModalRoute.of(context)!.settings.arguments as PopularModel;

    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
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
              background: Hero(
                tag: 'backdrop-${popular.id}',
                child: CachedNetworkImage(
                  imageUrl: popular.backdropPath,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(color: Colors.grey[900]),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey[900],
                    child: const Icon(Icons.error, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Reproductor de YouTube
                  Hero(
                    tag: 'trailer-${popular.id}',
                    child: Container(
                      width: 600,
                      height: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 6,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: YoutubePlayerScaffold(
                          controller: _ytController,
                          aspectRatio: 16 / 9,
                          builder: (context, player) => player,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Información general
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(8),
                    ),
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
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 12.0),
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 40,
                                      backgroundColor: Colors.grey[900],
                                      child: Text(
                                        '${index + 1}',
                                        style: const TextStyle(
                                          fontSize: 24,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Actor ${index + 1}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              );
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
}