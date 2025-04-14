import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_final/modules/about_devs/pages/about_devs.dart';
import 'package:proyecto_final/modules/members/pages/members.dart';
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
          title: 'Defensa Civil',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: Colors.deepOrangeAccent),
            useMaterial3: true,
          ),
          home: const Members(),
        );
      },
    );
  }
}
