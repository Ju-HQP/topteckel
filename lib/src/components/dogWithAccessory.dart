import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:topteckel/models/user.dart';
import 'package:topteckel/src/components/accessoryProperties.dart';
import 'package:topteckel/src/config.dart';
import '../topteckel.dart';

class DogWithAccessory extends SpriteComponent
    with DragCallbacks, HasGameReference<TopTeckel> {
  final User user;

  DogWithAccessory({
    required this.user,
    required double width,
    required double height,
  }) : super(
          anchor: Anchor.center,
        ) {
    // size = Vector2(150, 250); // Taille du chien
    // position = Vector2(width / 2, height * 0.85);
  }

  SpriteComponent? accessoryComponent;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    // Charger l'image du chien de base selon le choix de l'utilisateur
    final dogImage = await Flame.images.load(user.getDogImageGame());
    print("Chien image loaded: $dogImage");
    sprite = Sprite(dogImage);

    size = Vector2(dogWidth, dogHeight);

    position = Vector2(gameWidth / 2, gameHeight * 0.84);

    // Charger l'accessoire si disponible
    final accessory = accessoriesGame[user.accessory];
    if (accessory != null) {
      final accessoryImage = await Flame.images.load(accessory.imagePath);
      final accessorySprite = Sprite(accessoryImage);

      final accessoryComponent = SpriteComponent()
        ..sprite = accessorySprite
        ..size = Vector2(accessory.width, accessory.height)
        ..position = Vector2(
          (width / 2) + accessory.offsetX - (accessory.width / 2),
          (height / 2) + accessory.offsetY - (accessory.height / 2),
        );

      add(accessoryComponent); // Ajouter l'accessoire comme enfant du chien
    }
    add(RectangleHitbox());
  }

  // Méthode appelée lors du drag
  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    // Mettre à jour la position du chien avec le déplacement du doigt
    position.x = (position.x + event.localDelta.x).clamp(0, game.width);

    // Si l'accessoire existe, mettre à jour sa position
    if (accessoryComponent != null) {
      accessoryComponent!.position = Vector2(
        position.x + accessoryComponent!.size.x / 2,
        position.y - accessoryComponent!.size.y / 2,
      );
    }
  }

  void moveBy(double dx) {
    add(MoveToEffect(
      // Effects => chien animé vers une nouvelle position
      // clamp permet de faire sortir le chien de l'écran à mi-chemin en largeur (utile pour les smartphones)
      Vector2((position.x + dx).clamp(0, game.width), position.y),
      EffectController(duration: 0.1),
    ));
  }
}
