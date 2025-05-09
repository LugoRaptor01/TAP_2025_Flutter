import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/popular_model.dart';

class DetailedPopularMovie extends StatefulWidget {
  const DetailedPopularMovie({super.key});

  @override
  State<DetailedPopularMovie> createState() => _DetailedPopularMovieState();
}

class _DetailedPopularMovieState extends State<DetailedPopularMovie> {
  @override
  Widget build(BuildContext context) {

    final popular = ModalRoute.of(context)!.settings.arguments as PopularModel;
    return Container();
  }
}