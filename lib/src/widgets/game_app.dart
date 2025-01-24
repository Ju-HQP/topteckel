import 'package:flutter/material.dart';
import 'package:topteckel/src/config.dart';
import 'home_page.dart';
import 'game_page.dart';
import 'settings_page.dart';
import 'gacha_page.dart';
import 'historical_page.dart';
import 'player_profile_page.dart';
import 'signup_page.dart';
import 'waiting_page.dart';

class GameApp extends StatelessWidget {
  final bool userExists;
  const GameApp({super.key, required this.userExists});

  @override
  Widget build(BuildContext context) {
    gameWidth = MediaQuery.of(context).size.width;
    gameHeight = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
        primaryColor: const Color.fromARGB(255, 69, 26, 28),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromARGB(255, 69, 26, 28), width: 2.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromARGB(255, 69, 26, 28), width: 2.0),
          ),
          labelStyle: TextStyle(
            fontSize: 18,
            color: Color.fromARGB(255, 69, 26, 28),
          ),
        ),
      ),
      initialRoute: '/loading',
      routes: {
        '/loading': (context) => WaitingPage(userExists: userExists),
        '/home': (context) => const HomePage(),
        '/gameTopTeckel': (context) => const GamePage(),
        '/profile': (context) => const PlayerProfilePage(),
        '/settings': (context) => const SettingsPage(),
        '/gameGacha': (context) => const GachaPage(),
        '/historical': (context) => const HistoricalPage(),
        '/signUp': (context) => const SignUpPage(),
      },
    );
  }
}

class BackgroundPage extends StatelessWidget {
  final Widget child;

  const BackgroundPage({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image:
                AssetImage('assets/images/decor_default.png'), // Ton image ici
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(child: child), // Ton contenu (page) ici
      ),
    );
  }
}
