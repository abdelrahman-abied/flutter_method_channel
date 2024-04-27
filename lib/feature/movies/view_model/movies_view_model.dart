import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instabug_task/feature/movies/repo/movies_repository.dart';

import 'movies_state.dart';

class MoviesViewModel extends StateNotifier<MovieState> {
  final MoviesRepository moviesRepository;
  MoviesViewModel({required this.moviesRepository}) : super(MovieLoading());

  Future<void> loadMovies() async {
    try {
      final movies = await moviesRepository.getMovies();
      state = MovieLoaded(movies);
    } catch (e) {
      state = MovieError(message: e.toString());
    }
  }
}
