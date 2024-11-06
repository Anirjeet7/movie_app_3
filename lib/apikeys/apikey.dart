import 'dart:convert';

import 'package:movie_app_3/constants.dart';
import 'package:movie_app_3/mods/moviedetails.dart';
import 'package:http/http.dart' as http;

class Api {
  static const nowPlayingUrl =
      'https://api.themoviedb.org/3/movie/now_playing?api_key=${Constants.apikey}';
  static const popularUrl =
      'https://api.themoviedb.org/3/movie/popular?api_key=${Constants.apikey}';
  static const topRatedUrl =
      'https://api.themoviedb.org/3/movie/top_rated?api_key=${Constants.apikey}';
  static const upcomingUrl =
      'https://api.themoviedb.org/3/movie/upcoming?api_key=${Constants.apikey}';



  Future<List<Movie>> getnowPlaying() async {
    final response = await http.get(Uri.parse(nowPlayingUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      // print(decodedData);
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Some Error we might fix later.');
    }
  }
  Future<List<Movie>> getPopular() async {
    final response = await http.get(Uri.parse(popularUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      // print(decodedData);
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Some Error we might fix later.');
    }
  }
  Future<List<Movie>> getTopRated() async {
    final response = await http.get(Uri.parse(topRatedUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      // print(decodedData);
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Some Error we might fix later.');
    }
  }
  Future<List<Movie>> getUpcoming() async {
    final response = await http.get(Uri.parse(upcomingUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      // print(decodedData);
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Some Error we might fix later.');
    }
  }
}