import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


import '../topteckel.dart';
import '../config.dart';
import 'overlay_screen.dart'; 
import 'score_card.dart';
import 'home_page.dart';
import 'game_page.dart';
import 'settings_page.dart';
import 'player_profile_page.dart';

class GameApp extends StatelessWidget {
  const GameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomePage(),
        '/game': (context) => const GamePage(),
        '/profile': (context) => const PlayerProfilePage(),
        '/settings': (context) => const SettingsPage(),
      },
    );
  }
}
