import 'package:flutter/material.dart';
import 'models/database/dao.dart';
import 'models/user.dart';
// import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'src/widgets/game_app.dart';
import 'src/widgets/home_page.dart';
import 'src/widgets/settings_page.dart';
import 'src/widgets/player_profile_page.dart';

import 'src/widgets/waiting_page.dart';
import 'src/widgets/signup_page.dart';
import 'src/widgets/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Dao.database;
//Vérifier si un utilisateur existe dans la base de données
//final userExists2 = await Dao.userExists();

//if (!userExists2) {
//  final user = await Dao.createUser(User(
//  pseudoUser: 'TestUser',
//  passwordUser: '1234',
//  dateGame: DateTime.now(),
//  scoreGame: 100,
//  totalTicketsGame: 10,
//  colorDog: 1,
//  ));
//  print("User inserted: ${user.toJson()}");
//}

  runApp(const GameApp());
  //   runApp(const MyApp());
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         useMaterial3: true,
//         primarySwatch: Colors.blue,
//       ),
//       home: const SplashScreen(),
//     );
//   }
// }