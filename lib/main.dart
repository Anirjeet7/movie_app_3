import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_3/screens/wrapper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProviderScope( // Wrapping the app with ProviderScope
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movies Hub',
        home: Wrapper(),
      ),
    );
  }
}
