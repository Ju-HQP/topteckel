import 'package:flutter/material.dart';
import 'models/database/dao.dart';
import 'models/user.dart';
import 'models/question.dart';
import 'src/widgets/game_app.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Dao.clearDatabase(); 
  await Dao.populateQuestionsIfEmpty();
  await Dao.database;
//   User user = User(
//   pseudoUser: "JohnDoe",
//   dateGame: DateTime.now(),
//   scoreGame: 100,
//   totalTicketsGame: 10,
//   colorDog: 1,
//   accessory: "Hat",
// );
  //Vérifie si un utilisateur existe dans la base de données
  bool userExists = await Dao.userExists();
  

  runApp(GameApp(userExists: userExists));
}