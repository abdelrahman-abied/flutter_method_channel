import 'package:flutter/material.dart';
import 'package:instabug_task/feature/movies/model/movie_model.dart';

sealed class MovieState {}

class MovieLoading extends MovieState {}

class MovieLoaded extends MovieState {
  final List<Movie> movies;

  MovieLoaded(this.movies);
}

class MovieError extends MovieState {
  final String message;
  final IconData? icon;

  MovieError({required this.message, this.icon});
}
