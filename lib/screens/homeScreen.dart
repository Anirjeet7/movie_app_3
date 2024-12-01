import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_3/models/cardSlider.dart';
import 'package:movie_app_3/models/movieSlider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app_3/apikeys/apikey.dart';
import 'package:movie_app_3/mods/moviedetails.dart';

class homeScreen extends StatelessWidget {
  const homeScreen({super.key});

  signout() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(172, 43, 43, 43),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Movie App', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
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
                style: GoogleFonts.alkatra(fontSize: 30, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 16),
              FutureBuilder<List<Movie>>(
                future: Api().getnowPlaying(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text(snapshot.toString()));
                  } else if (snapshot.hasData) {
                    return CardSlider(snapshot: snapshot);
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
              const SizedBox(height: 16),
              Text('Popular Movies', style: GoogleFonts.alkatra(fontSize: 30)),
              const SizedBox(height: 16),
              FutureBuilder<List<Movie>>(
                future: Api().getPopular(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text(snapshot.toString()));
                  } else if (snapshot.hasData) {
                    return MoviesSlider(snapshot: snapshot);
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
              const SizedBox(height: 16),
              Center(
                child: FloatingActionButton(
                  onPressed: signout,
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
