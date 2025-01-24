import 'package:flame/components.dart';
import '../topteckel.dart';


class DynamicBackground extends Component with HasGameReference<TopTeckel> {
  List<String> backgroundDefault = [
    'decor_default.png',
    'decor_game_skyblue_2.png',
  ];

  List<String> backgroundsPalierSkyblue = [
    'decor_game_skyblue_2.png',
    'decor_game_skyblue_1.png',
  ];

  List<String> transitionPalierSkyBlueSkyDark = [
    'decor_game_skyblue_3.png',
    'decor_game_skydark_5.png',
  ];

  List<String> backgroundsPalierSkyDark = [
    'decor_game_skydark_5.png',
    'decor_game_skydark_4.png',
  ];

  List<String> backgroundsPalierSpace = [
    'decor_game_space_6.png',
    'decor_game_space_7.png',
  ];

  // Liste actuelle et index
  List<String> currentBackgrounds = [];
  int currentIndex = 0;

  late SpriteComponent background1;
  late SpriteComponent background2;
  // Vitesse de défilement (pixels/seconde)
  final double scrollSpeed = 70;

  // Début avec un fond fixe
  bool isMovementStarted = false;

  // État pour suivre la transition
  bool isInTransition = false;

  @override
  Future<void> onLoad() async { // Future permet au programme de continuer de fonctionner pendant que la tâche s'effectue en arrière-plan 
    super.onLoad();
    
    currentBackgrounds = backgroundDefault;
    // Charger les deux premiers arrière-plans
    background1 = SpriteComponent()
      ..sprite = await game.loadSprite(currentBackgrounds[0])
      ..size = Vector2(game.width, game.height)
      ..position = Vector2(0, 0);

    background2 = SpriteComponent()
      ..sprite = await game.loadSprite(currentBackgrounds[1])
      ..size = Vector2(game.width, game.height)
      ..position = Vector2(0, -game.height);

    add(background1);
    add(background2);
  }

  // Méthode pour mettre à jour la liste en fonction du score
  void updateBackgroundList() {
    // Transition à SkyDark uniquement si isInTransition est false
    if (game.score.value < 20) {
      if (!isInTransition) {
        currentBackgrounds = [
          ...currentBackgrounds,
          ...transitionPalierSkyBlueSkyDark,
        ];
        isInTransition = true;
      }
      else {
        currentBackgrounds = backgroundsPalierSkyblue;
      }
    } 
    // Transition avant de passer à SkyDark
    else if (game.score.value <= 50) {
        currentBackgrounds = backgroundsPalierSkyDark;
    } 
    else {
      currentBackgrounds = backgroundsPalierSpace;
    }
  }

  Future<void> reloadBackgroundSprites(SpriteComponent background, int index) async {
    background.sprite = await game.loadSprite(currentBackgrounds[index % currentBackgrounds.length]);
  }

  @override
  void update(double dt) async {
    super.update(dt);

    // Mettre à jour la liste de backgrounds en fonction du score
    updateBackgroundList();

    if (game.score.value >= 3) {
    // Déplacer les arrière-plans vers le bas
    background1.position.y += scrollSpeed * dt;
    background2.position.y += scrollSpeed * dt;

    // Réinitialiser les positions des arrière-plans et recharger les sprites si nécessaire
    if (background1.position.y >= game.height) {
      background1.position.y = background2.position.y - game.height;
      currentIndex++;
      await reloadBackgroundSprites(background1, currentIndex);
    }
    if (background2.position.y >= game.height) {
      background2.position.y = background1.position.y - game.height;
      currentIndex++;
      await reloadBackgroundSprites(background2, currentIndex);
    }
    }
  }
}
