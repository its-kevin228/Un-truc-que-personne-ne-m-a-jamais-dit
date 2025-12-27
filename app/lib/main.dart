import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Un truc que personne ne m\'a jamais dit',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0D0D0D),
        primaryColor: const Color(0xFFE8B4B8),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFE8B4B8),
          secondary: Color(0xFF67597A),
          surface: Color(0xFF1A1A1A),
        ),
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
      ),
      home: const HomeScreen(),
    );
  }
}
