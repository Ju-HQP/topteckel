import 'dart:convert';
import 'dart:math';

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

  static Future<void> deleteExistingDatabase(String filePath) async {
    // Obtenez le chemin de la base de données
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    // Supprimez la base de données
    await deleteDatabase(path);
    print('Base de données supprimée : $path');
  }

  //_initDB initialise notre base de données.
  static Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    print(
        "Database path: $path"); // Pour vérifier le chemin de la base de données
    //openDatabase ouvre notre base de données située à l'emplacement "path"
    //si la base n'existe pas openDatabase exécute _createDB
     await openDatabase(path, version: 1, onCreate: _createDB);
    return await openDatabase(
      path,
      version: 2,
      onUpgrade: _onUpgrade,
    );
  }

  //_createDB est la méthode qui s'occupe de la définition des tables de notre base de données
  //_createDB exécute les transactions de base de données pour créer les tables
  static Future _createDB(Database db, int version) async {
    _onUpgrade(db, 1, version);
    print("Creating database tables...");
    await db.execute('''
      CREATE TABLE user (
        id_user INTEGER PRIMARY KEY AUTOINCREMENT,
        pseudo_user VARCHAR(255) NOT NULL,
        date_game DATETIME,
        score_game INTEGER,
        total_tickets_game INTEGER,
        color_dog INTEGER,
        accessory VARCHAR(255),
        accessoriesList TEXT
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

  static Future<void> clearDatabase() async {
    final db = await database; // Obtenez votre base de données
    await db.delete('user'); // Remplacez 'users' par le nom de votre table
    print("Database cleared.");
  }

  static Future<List<User>> listUsers() async {
    final db = await database;

    print("Fetching users...");
    final maps = await db.query(
      "user",
      columns: ["*"],
    );
    print("Users retrieved: $maps");
    if (maps.isNotEmpty) {
      return maps.map((e) {
        final user = User.fromJson(e);

        // Vérifie si accessoriesList est une String avant de tenter de décoder
        var accessoriesListJson = e["accessoriesList"];

        if (accessoriesListJson is String && accessoriesListJson.isNotEmpty) {
          try {
            // Tentative de décodage du JSON
            user.accessoriesList =
                jsonDecode(accessoriesListJson).cast<String>();
          } catch (err) {
            print("Erreur lors du décodage de accessoriesList : $err");
            user.accessoriesList = []; // Valeur par défaut en cas d'erreur
          }
        } else {
          // Si l'élément n'est pas une chaîne, ou est nul
          print("accessoriesList n'est pas une chaîne: $accessoriesListJson");
          user.accessoriesList = []; // Valeur par défaut
        }

        return user;
      }).toList();
    } else {
      return [];
    }
  }

  static Future<int> updateUser(User user) async {
    final db = await database;
    final data = Map<String, dynamic>.from(user.toJson())
      ..remove("id_user")
      ..update(
        "accessory",
        (_) => user.accessory,
        ifAbsent: () => user.accessory,
      )
      ..update(
        "accessoriesList",
        (_) => jsonEncode(user.accessoriesList),
        ifAbsent: () => jsonEncode(user.accessoriesList),
      );

    return await db.update(
      'user',
      data,
      where: 'id_user = ?',
      whereArgs: [user.idUser],
    );
  }

  static Future<User> createUser(User user) async {
    final db = await database;
    final idNew = await db.insert("user", {
      ...user.toJson(),
      'accessoriesList': jsonEncode(user.accessoriesList),
    });
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

  // Vérifie si un utilisateur existe déjà dans la base de données
  static Future<bool> userExists() async {
    final db = await database;
    final result = await db.query(
      "user",
      columns: ["id_user"],
      limit: 1,
    );
    return result.isNotEmpty;
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

  static Future<void> populateQuestionsIfEmpty() async {
    final db = await database;

    final count = Sqflite.firstIntValue(
      await db.rawQuery("SELECT COUNT(*) FROM question"),
    );

    if (count == 0) {
      List<Question> initialQuestions = [
        Question(
          titleQuestion: "Quelle est la capitale de la France ?",
          goodResponseQuestion: "Paris",
          badResponsesQuestion: ["Lyon", "Marseille", "Bordeaux"],
        ),
        Question(
          titleQuestion:
              "Quelle est la plus grande planète du système solaire ?",
          goodResponseQuestion: "Jupiter",
          badResponsesQuestion: ["Saturne", "Mars", "Terre"],
        ),
      ];

      for (var question in initialQuestions) {
        await db.insert("question", question.toJson());
      }
    }
  }

  Future<Question> getRandomQuestion() async {
    final questions = await Dao.listQuestions();
    if (questions.isNotEmpty) {
      return questions[Random().nextInt(questions.length)];
    } else {
      throw Exception("No questions available");
    }
  }

  // Future<Question> getRandomAccessory() async {
  //   final accessories = await Dao.listAccessories();
  //   if (accessories.isNotEmpty) {
  //     return accessories[Random().nextInt(accessories.length)];
  //   } else {
  //     throw Exception("No questions available");
  //   }
  // }

  static Future<void> _onUpgrade(
      Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Version 2 avec modification de la table
      print("Old version !!!");
      // print("Database upgraded: 'accessory' column added to 'user' table.");
      await db.execute('''
      CREATE TABLE user_new (
        id_user INTEGER PRIMARY KEY AUTOINCREMENT,
        pseudo_user VARCHAR(255) NOT NULL,
        date_game DATETIME,
        score_game INTEGER,
        total_tickets_game INTEGER,
        color_dog INTEGER,
        accessory VARCHAR(255),
        accessoriesList TEXT
      )
    ''');

      // Copier les anciennes données dans la nouvelle table
      await db.execute('''
      INSERT INTO user_new (id_user, pseudo_user, date_game, score_game, total_tickets_game, color_dog, accessory, accessoriesList)
      SELECT id_user, pseudo_user, date_game, score_game, total_tickets_game, color_dog, accessory, accessoriesList
      FROM user
    ''');

      // Supprimer l'ancienne table
      await db.execute('DROP TABLE user');

      // Renommer la nouvelle table
      await db.execute('ALTER TABLE user_new RENAME TO user');
      await db.execute("ALTER TABLE user ADD COLUMN accessoriesList TEXT;");
    }
  }
}
