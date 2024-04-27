import 'package:flutter/material.dart';
import 'package:instabug_task/core/constants/constant.dart';
import 'package:instabug_task/core/utilities/extensions.dart';
import 'package:instabug_task/core/widget/image_with_shimmer.dart';
import 'package:instabug_task/feature/movies/model/movie_model.dart';
import 'package:instabug_task/feature/movies/view/details_view.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  const MovieCard({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MovieDetailView(movie: movie),
          ),
        );
      },
      child: Container(
        height: 175,
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              spreadRadius: 1,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Hero(
                tag: movie.id ?? "",
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: ImageWithShimmer(
                    imageUrl: '${Constant.imageUrl}${movie.posterPath}',
                    width: 110,
                    height: double.infinity,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Text(
                      movie.title ?? "",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.titleSmall,
                    ),
                  ),
                  Row(
                    children: [
                      if (movie.releaseDate!.isNotEmpty) ...[
                        Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Text(
                            movie.releaseDate!.toNamedDate(),
                            textAlign: TextAlign.center,
                            style: textTheme.bodyLarge,
                          ),
                        ),
                      ],
                      Icon(
                        Icons.star_rate_rounded,
                        color: Colors.yellow.shade900,
                        size: 18,
                      ),
                      Text(
                        movie.voteAverage.toString(),
                        style: textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 14),
                    child: Text(
                      movie.overview ?? "",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
