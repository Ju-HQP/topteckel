import 'package:flutter/material.dart';
import 'models/database/dao.dart';
import 'src/widgets/game_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Remplit la base de données de questions
  await Dao.populateQuestions();
  await Dao.database;

  //Vérifie si un utilisateur existe dans la base de données
  bool userExists = await Dao.userExists();
  
  runApp(GameApp(userExists: userExists));
}