import 'package:flutter/material.dart';
import 'package:movie_app_3/constants.dart';
import 'package:movie_app_3/mods/moviedetails.dart';
import 'package:google_fonts/google_fonts.dart';

class moviesOverview extends StatelessWidget {
  const moviesOverview({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            leading: Container(
              height: 70,
              width: 70,
              margin: const EdgeInsets.only(top: 15, left: 15),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 3, 60, 43),
                borderRadius: BorderRadius.circular(8),
              ),
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_sharp)),
            ),
            backgroundColor: const Color.fromARGB(255, 3, 60, 43),
            floating: true,
            expandedHeight: 400,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                movie.title,
                style: GoogleFonts.tinos(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              background: Image.network(
                '${Constants.imagePath}${movie.posterPath}',
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
          SliverToBoxAdapter(
              child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Text("Overview",
                          style: GoogleFonts.roboto(
                              fontSize: 25, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 15),
                      Text(
                        movie.overview,
                        style: GoogleFonts.montserrat(fontSize: 20),
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Text('Release Date: ',
                                      style: GoogleFonts.outfit(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300,
                                      )),
                                  Text(movie.releaseDate, style: GoogleFonts.outfit(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                  )),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Row(children: [
                                Text('Rating: ', style: GoogleFonts.outfit(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                )),
                                const Icon(Icons.star, color: Colors.amber),
                                Text('${movie.voteAverage.toStringAsFixed(1)}/10', style: GoogleFonts.outfit(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                ),)
                              ],),
                            )
                          ],
                        ),
                      )
                    ],
                  ))),
        ],
      ),
    );
  }
}
