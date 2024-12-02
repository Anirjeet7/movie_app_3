import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_3/models/cardSlider.dart';
import 'package:movie_app_3/models/movieSlider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app_3/apikeys/apikey.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class homeScreen extends ConsumerWidget {
  const homeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nowPlaying = ref.watch(nowPlayingProvider);
    final popular = ref.watch(popularProvider);
    final topRated = ref.watch(topRatedProvider);
    final upcoming = ref.watch(upcomingProvider);

    return Scaffold(
      backgroundColor: const Color.fromARGB(172, 43, 43, 43),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Movie App',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing',
                style: GoogleFonts.alkatra(
                    fontSize: 30, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 16),
              SizedBox(
                child: nowPlaying.when(
                  data: (movies) => CardSlider(movies: movies),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  error: (err, stack) => Center(
                    child: Text(err.toString()),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Popular Movies',
                style: GoogleFonts.alkatra(fontSize: 30),
              ),
              const SizedBox(height: 16),
              SizedBox(
                child: popular.when(
                  data: (movies) => MoviesSlider(movies: movies),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  error: (err, stack) => Center(
                    child: Text(err.toString()),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Top Rated',
                style: GoogleFonts.alkatra(fontSize: 30),
              ),
              const SizedBox(height: 16),
              SizedBox(
                child: topRated.when(
                  data: (movies) => MoviesSlider(movies: movies),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  error: (err, stack) => Center(
                    child: Text(err.toString()),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Upcoming movies',
                style: GoogleFonts.alkatra(fontSize: 30),
              ),
              const SizedBox(height: 16),
              SizedBox(
                child: upcoming.when(
                  data: (movies) => MoviesSlider(movies: movies),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  error: (err, stack) => Center(
                    child: Text(err.toString()),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: FloatingActionButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                  },
                  child: const Icon(Icons.login_rounded),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
