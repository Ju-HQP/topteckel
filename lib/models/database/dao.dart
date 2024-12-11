import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:topteckel/models/user.dart';
import 'package:topteckel/models/question.dart';

//_database est la reférence de notre base de données
//database est un getter qui renvoie l’objet de base de données. Si la base n’existe pas, _initDB la créé
//_initDB initialise notre base de données.
//_createDB est la méthode qui s’occupe de la définition des tables de notre base de données. Elle exécute les transactions de base de données pour créer les tables.

class Dao {
  //La reférence de notre base de données
  static Database? _database;

  //Un getter qui renvoie l'objet de base de donnée.
  //Si la base n'existe pas _initDB la créé
  static Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('topteckel.db');
    return _database!;
  }

  //_initDB initialise notre base de données.
  static Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    print("Database path: $path");  // Pour vérifier le chemin de la base de données
    //openDatabase ouvre notre base de données située à l'emplacement "path"
    //si la base n'existe pas openDatabase exécute _createDB
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  //_createDB est la méthode qui s'occupe de la définition des tables de notre base de données
  //_createDB exécute les transactions de base de données pour créer les tables
  static Future _createDB(Database db, int version) async {
    print("Creating database tables...");
    await db.execute('''
      CREATE TABLE user (
        id_user INTEGER PRIMARY KEY AUTOINCREMENT,
        pseudo_user VARCHAR(255) NOT NULL,
        password_user VARCHAR(255) NOT NULL,
        date_game DATETIME,
        score_game INTEGER,
        total_tickets_game INTEGER,
        color_dog INTEGER
        )
      ''');
    await db.execute('''
      CREATE TABLE question (
        id_question INTEGER PRIMARY KEY AUTOINCREMENT,
        title_question VARCHAR(255) NOT NULL,
        good_response_question VARCHAR(255) NOT NULL,
        bad_responses_question VARCHAR(255) NOT NULL
      )
      ''');
    print("Database tables created.");
  }

  static Future<List<User>> listUsers() async {
    final db = await database;

    final maps = await db.query(
      "user",
      columns: ["*"],
    );

    if (maps.isNotEmpty) {
      return maps.map((e) => User.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  static Future<int> updateUser(User user) async {
    final db = await database;
    final data = Map<String, dynamic>.from(user.toJson())..remove("id_user");
    return db.update(
      "user",
      data,
      where: 'id_user = ?',
      whereArgs: [user.idUser],
    );
  }

  static Future<User> createUser(User user) async {
    final db = await database;
    final idNew = await db.insert("user", user.toJson());
    user.idUser = idNew;
    return user;
  }

  static Future<int> deleteUser(int id) async {
    final db = await database;
    return await db.delete(
      "user",
      where: 'id_user = ?',
      whereArgs: [id],
    );
  }

  static Future<List<Question>> listQuestions() async {
    final db = await database;

    final maps = await db.query(
      "question",
      columns: ["*"],
    );

    if (maps.isNotEmpty) {
      return maps.map((e) => Question.fromJson(e)).toList();
    } else {
      return [];
    }
  }
}