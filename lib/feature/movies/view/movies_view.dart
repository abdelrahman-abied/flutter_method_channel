import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instabug_task/core/widget/error_widget.dart';
import 'package:instabug_task/feature/movies/view/widget/movie_card.dart';
import 'package:instabug_task/feature/movies/view_model/movies_state.dart';
import 'package:instabug_task/providers.dart';

class MoviesView extends ConsumerStatefulWidget {
  const MoviesView({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MoviesViewState();
}

class _MoviesViewState extends ConsumerState<MoviesView> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await ref.read(moviesViewModelProvider.notifier).loadMovies();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final moviesViewModel = ref.watch(moviesViewModelProvider);
    final networkInfo = ref.watch(networkInfoProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
          future: networkInfo.isConnected,
          builder: (context, AsyncSnapshot<bool> snapshot) {
            return Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if ((moviesViewModel is MovieError) && snapshot.data! == false)
                  ErrorWidget(
                    message: 'No Internet Connection',
                    onPress: () {
                      ref.read(moviesViewModelProvider.notifier).loadMovies();
                    },
                  )
                else if (moviesViewModel is MovieLoading)
                  const Center(
                    child: CircularProgressIndicator(),
                  )
                else if (moviesViewModel is MovieLoaded)
                  Expanded(
                    child: ListView.builder(
                      itemCount: moviesViewModel.movies.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final movie = moviesViewModel.movies[index];
                        return MovieCard(movie: movie);
                      },
                    ),
                  )
                else if (moviesViewModel is MovieError)
                  ErrorWidget(
                    message: 'Movies Not Found',
                    onPress: () {
                      ref.read(moviesViewModelProvider.notifier).loadMovies();
                    },
                  ),
              ],
            );
          }),
    );
  }
}
