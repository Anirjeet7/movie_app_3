import 'package:flutter/material.dart';
import 'package:movie_app_3/constants.dart';
import 'package:movie_app_3/screens/movieOverview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app_3/mods/moviedetails.dart';

class MoviesSlider extends ConsumerWidget {
  const MoviesSlider({
    super.key,
    required this.movies,
  });

  final List<Movie> movies;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 300,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        moviesOverview(movie: movies[index]),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  height: 300,
                  width: 200,
                  child: Image.network(
                    '${Constants.imagePath}${movies[index].posterPath}',
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
