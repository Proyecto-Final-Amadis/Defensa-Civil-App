import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_final/modules/about_devs/pages/about_devs.dart';
import 'package:proyecto_final/modules/defense_services/pages/defense_services.dart';
import 'package:proyecto_final/modules/news/pages/news_list.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(
    ProviderScope(child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Defensa Civil',
          theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: Colors.deepOrangeAccent),
            useMaterial3: true,
          ),
          home: const AboutDevs(),
        );
      },
    );
  }
}
