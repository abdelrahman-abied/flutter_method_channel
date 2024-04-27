import 'package:instabug_task/core/constants/constant.dart';
import 'package:instabug_task/core/data/data_retriever.dart';
import 'package:instabug_task/core/utilities/cache_helper.dart';
import 'package:instabug_task/feature/movies/model/movie_model.dart';

class MovieApi {
  final CacheHelper cacheHelper;
  final DataRetriever dataRetriver;
  MovieApi({required this.dataRetriver, required this.cacheHelper});

  Future<List<Movie>> fetchMovies() async {
    try {
      final json = await dataRetriver.getData();
      if (json != null) {
        cacheHelper.savePrefs(key: Constant.moviesKey, value: json);
      }
      return movieModelFromJson(json!).results ?? [];
    } catch (e) {
      rethrow;
    }
  }
}
