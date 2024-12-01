import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app_3/models/cardSlider.dart';
import 'package:movie_app_3/models/movieSlider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app_3/apikeys/apikey.dart';
import 'package:movie_app_3/mods/moviedetails.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});
  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  final user = FirebaseAuth.instance.currentUser;

  signout() async {
    await FirebaseAuth.instance.signOut();
  }

  late Future<List<Movie>> nowPlaying;
  late Future<List<Movie>> popular;
  late Future<List<Movie>> topRated;
  late Future<List<Movie>> upcoming;

  @override
  void initState() {
    super.initState();
    nowPlaying = Api().getnowPlaying();
    popular = Api().getPopular();
    topRated = Api().getTopRated();
    upcoming = Api().getUpcoming();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(172, 43, 43, 43),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Movie App',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
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
              // Now Playing Section
              Text(
                'Now Playing',
                style: GoogleFonts.alkatra(
                    fontSize: 30, fontWeight: FontWeight.w500, color: Colors.white),
              ),
              const SizedBox(height: 16),
              SizedBox(
                child: FutureBuilder(
                    future: nowPlaying,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.toString()),
                        );
                      } else if (snapshot.hasData) {
                        return CardSlider(
                          snapshot: snapshot,
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ),

              const SizedBox(height: 16),
              // Popular Movies Section
              Text(
                'Popular Movies',
                style: GoogleFonts.alkatra(fontSize: 30, color: Colors.white),
              ),
              const SizedBox(height: 16),
              SizedBox(
                child: FutureBuilder(
                    future: popular,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.toString()),
                        );
                      } else if (snapshot.hasData) {
                        return MoviesSlider(
                          snapshot: snapshot,
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ),

              const SizedBox(height: 16),
              // Top Rated Movies Section
              Text(
                'Top Rated',
                style: GoogleFonts.alkatra(fontSize: 30, color: Colors.white),
              ),
              const SizedBox(height: 16),
              SizedBox(
                child: FutureBuilder(
                    future: topRated,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.toString()),
                        );
                      } else if (snapshot.hasData) {
                        return MoviesSlider(
                          snapshot: snapshot,
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ),

              const SizedBox(height: 16),
              // Upcoming Movies Section
              Text(
                'Upcoming Movies',
                style: GoogleFonts.alkatra(fontSize: 30, color: Colors.white),
              ),
              const SizedBox(height: 16),
              SizedBox(
                child: FutureBuilder(
                    future: upcoming,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.toString()),
                        );
                      } else if (snapshot.hasData) {
                        return MoviesSlider(
                          snapshot: snapshot,
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ),

              SizedBox(height: 20),
              // Sign out Button
              Center(
                child: FloatingActionButton(
                  onPressed: () => signout(),
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
