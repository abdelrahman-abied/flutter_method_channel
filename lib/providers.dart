import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instabug_task/feature/movies/model/data_source/remote_source.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/constants/constant.dart';
import 'core/data/data_retriever.dart';
import 'core/network/network_info.dart';
import 'core/utilities/cache_helper.dart';
import 'feature/movies/repo/movies_repository.dart';
import 'feature/movies/view_model/movies_state.dart';
import 'feature/movies/view_model/movies_view_model.dart';

final networkCheckerProvider = Provider(
  (ref) => InternetConnectionChecker(),
);
final networkInfoProvider = Provider(
  (ref) {
    final networkChecker = ref.watch(networkCheckerProvider);
    return NetworkInfoImpl(connectionChecker: networkChecker);
  },
);
final sharePreferencesProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError(),
);

final cacheHelperProvider = Provider<CacheHelper>((ref) {
  final sharedPreferences = ref.watch(sharePreferencesProvider);
  return CacheHelper(sharedPreferences);
});

// movies view model providers
final dataRetrieverProvider = Provider(
  (ref) => DataRetriever(Constant.androidChannel, Constant.iosChannel),
);
final movieApiProvider = Provider((ref) => MovieApi(
      cacheHelper: ref.watch(cacheHelperProvider),
      dataRetriver: ref.watch(dataRetrieverProvider),
    ));
final moviesRepositoryProvider = Provider(
  (ref) {
    final networkInfo = ref.watch(networkInfoProvider);
    final cacheHelper = ref.watch(cacheHelperProvider);
    final movieApi = ref.watch(movieApiProvider);
    return MoviesRepository(
      movieApi: movieApi,
      networkInfo: networkInfo,
      cacheHelper: cacheHelper,
    );
  },
);
final moviesViewModelProvider = StateNotifierProvider<MoviesViewModel, MovieState>((ref) {
  final moviesRepository = ref.watch(moviesRepositoryProvider);
  return MoviesViewModel(moviesRepository: moviesRepository);
});
