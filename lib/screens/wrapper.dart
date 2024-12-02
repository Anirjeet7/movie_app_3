import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_3/screens/homeScreen.dart';
import 'package:movie_app_3/screens/login.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Wrapper extends ConsumerWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider);

    return Scaffold(
      body: user.when(
        data: (user) {
          if (user != null) {
            return const homeScreen();
          } else {
            return const PhoneHome();
          }
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text(err.toString())),
      ),
    );
  }
}

final authStateProvider = StreamProvider((ref) => FirebaseAuth.instance.authStateChanges());
