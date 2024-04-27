import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instabug_task/providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'feature/movies/view/movies_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPreference = await SharedPreferences.getInstance();
  final container = ProviderContainer(
    overrides: [
      sharePreferencesProvider.overrideWithValue(sharedPreference),
    ],
  );
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instabug Task',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MoviesView(title: 'Instabug Task'),
    );
  }
}
