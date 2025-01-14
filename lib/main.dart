import 'package:flutter/material.dart';
import 'models/database/dao.dart';
import 'models/user.dart';
import 'models/question.dart';
// import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'src/widgets/game_app.dart';
// import 'src/widgets/home_page.dart';
// import 'src/widgets/settings_page.dart';
// import 'src/widgets/player_profile_page.dart';

// import 'src/widgets/waiting_page.dart';
// import 'src/widgets/signup_page.dart';
// import 'src/widgets/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Dao.clearDatabase(); 
  await Dao.populateQuestionsIfEmpty();
  await Dao.database;
  //Vérifie si un utilisateur existe dans la base de données
  bool userExists = await Dao.userExists();
  // bool userExists = false;
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

  runApp(GameApp(userExists: userExists));
}