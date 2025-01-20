import 'dart:convert';

class User {
  int? idUser;
  String? pseudoUser;
  DateTime? dateGame;
  int? scoreGame=0;
  int? totalTicketsGame=0;
  int? colorDog;
  String? accessory;
  List<String> accessoriesList;

  User({this.idUser, this.pseudoUser, this.dateGame, this.scoreGame=0, this.totalTicketsGame=0, this.colorDog, this.accessory, this.accessoriesList=const["chapeau-TopTeckel"]});

  factory User.fromJson(Map<String, dynamic> json) {
    var accessoriesListJson = json['accessoriesList'];
    // Vérifie si accessoriesList est une chaîne de caractères
    if (accessoriesListJson is String) {
      // Si c'est une chaîne, décode-la en une liste
      try {
        accessoriesListJson = jsonDecode(accessoriesListJson);
      } catch (e) {
        // Gère l'erreur de décodage si la chaîne est invalide
        accessoriesListJson = [];
      }
    }

    // Si accessoriesList est une liste, on la récupère normalement
    if (accessoriesListJson is List) {
      return User(
        accessoriesList: List<String>.from(accessoriesListJson),
        idUser: json["id_user"] ?? 0, // Assurez-vous d'avoir une valeur par défaut
  pseudoUser: json["pseudo_user"] ?? '',
  dateGame: json["date_game"] != null ? DateTime.tryParse(json["date_game"]) : null,
  scoreGame: json["score_game"] ?? 0,
  totalTicketsGame: json["total_tickets_game"] ?? 0,
  colorDog: json["color_dog"] ?? 0,
  accessory: json["accessory"]);
    } else {
      // Si ce n'est pas une liste valide, retourne une liste vide ou autre valeur par défaut
      return User(
        accessoriesList: [],
  idUser: json["id_user"] ?? 0, // Assurez-vous d'avoir une valeur par défaut
  pseudoUser: json["pseudo_user"] ?? '',
  dateGame: json["date_game"] != null ? DateTime.tryParse(json["date_game"]) : null,
  scoreGame: json["score_game"] ?? 0,
  totalTicketsGame: json["total_tickets_game"] ?? 0,
  colorDog: json["color_dog"] ?? 0,
  accessory: json["accessory"]);
}
}
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map["id_user"] = idUser;
    map["pseudo_user"] = pseudoUser;
    map["date_game"] = dateGame?.toIso8601String();
    map["score_game"] = scoreGame;
    map["total_tickets_game"] = totalTicketsGame;
    map["color_dog"] = colorDog;
    map["accessory"]= accessory;
    map["accessoriesList"] = jsonEncode(accessoriesList);
    return map;
  }

  String getDogImage() {
    switch (colorDog) {
      case 1:
        return 'assets/images/teckel_1.png';
      case 2:
        return 'assets/images/teckel_2.png';
      case 3:
        return 'assets/images/teckel_3.png';
      case 4:
        return 'assets/images/teckel_4.png';
      default:
        return 'assets/images/teckel_1.png'; // Valeur par défaut si aucune couleur n'est définie
    }
  }

  String getDogImageGame() {
    switch (colorDog) {
      case 1:
        return 'teckel_1.png';
      case 2:
        return 'teckel_2.png';
      case 3:
        return 'teckel_3.png';
      case 4:
        return 'teckel_4.png';
      default:
        return 'teckel_1.png'; // Valeur par défaut si aucune couleur n'est définie
    }
  }
}
