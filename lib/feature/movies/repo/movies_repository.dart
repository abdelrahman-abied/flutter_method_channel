import 'package:instabug_task/core/constants/constant.dart';
import 'package:instabug_task/core/network/network_info.dart';
import 'package:instabug_task/core/utilities/cache_helper.dart';
import 'package:instabug_task/feature/movies/model/data_source/remote_source.dart';
import 'package:instabug_task/feature/movies/model/movie_model.dart';

class MoviesRepository {
  final NetworkInfo networkInfo;
  final CacheHelper cacheHelper;
  final MovieApi movieApi;
  MoviesRepository({
    required this.movieApi,
    required this.networkInfo,
    required this.cacheHelper,
  });

  Future<List<Movie>> getMovies() async {
    try {
      final isConnected = await networkInfo.isConnected;
      if (isConnected) {
        final movies = await movieApi.fetchMovies();
        return movies;
      } else {
        final movies = await getSavedMovies();
        return movies;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Movie>> getSavedMovies() async {
    try {
      final String json = cacheHelper.getPrefs(key: Constant.moviesKey);
      final movies = movieModelFromJson(json).results ?? [];
      return movies;
    } catch (e) {
      rethrow;
    }
  }
}
