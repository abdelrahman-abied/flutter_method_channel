import 'package:flutter/material.dart';
import 'package:instabug_task/core/constants/constant.dart';
import 'package:instabug_task/core/utilities/extensions.dart';
import 'package:instabug_task/core/widget/image_with_shimmer.dart';

import '../model/movie_model.dart';

class MovieDetailView extends StatelessWidget {
  final Movie movie;
  const MovieDetailView({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title ?? ""),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: ListView(
        children: [
          Hero(
            tag: movie.id ?? "",
            child: ImageWithShimmer(
              imageUrl: '${Constant.imageUrl}${movie.backdropPath}',
              width: 110,
              height: size.height * 0.4,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      movie.title ?? "",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star_rate_rounded,
                          color: Colors.yellow.shade900,
                          size: 18,
                        ),
                        Text(
                          movie.voteAverage.toString(),
                        ),
                      ],
                    ),
                  ],
                ),
                if (movie.releaseDate!.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Text(
                      movie.releaseDate!.toNamedDate(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                Text(movie.overview ?? ""),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
