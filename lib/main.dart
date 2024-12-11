// import 'package:flame/game.dart';
// import 'package:flutter/material.dart';
 
// import "src/topteckel.dart";

// void main() {
//   final game = TopTeckel();
//   runApp(GameWidget(game: game));
// }

import 'package:flutter/material.dart';
import 'models/database/dao.dart';
// import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'src/widgets/game_app.dart';
// import 'src/widgets/home_page.dart';
// import 'src/widgets/settings_page.dart';
// import 'src/widgets/player_profile_page.dart';


void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Dao.database;
  runApp(const GameApp());
}
