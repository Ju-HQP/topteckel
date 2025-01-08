import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart'; // event d'interaction (ici drag)

import '../topteckel.dart';

class Dog extends SpriteComponent // positionComponent affiche l'objet à l'écran (remplace render)
    with DragCallbacks, HasGameReference<TopTeckel> { // dragCallBacks pour l'interaction de drag
  Dog({
    // required this.cornerRadius,
    required super.position,
    required super.size,
  }) : super(
          anchor: Anchor.center,
          // children: [RectangleHitbox()],
        );

  // final Radius cornerRadius;

  // final _paint = Paint()
  //   ..color = const Color(0xff1e6091)
  //   ..style = PaintingStyle.fill;

  // @override
  // void render(Canvas canvas) {
  //   super.render(canvas);
  //   canvas.drawRRect( // dessin d'un rectangle arrondi
  //       RRect.fromRectAndRadius(
  //         Offset.zero & size.toSize(),
  //         cornerRadius,
  //       ),
  //       _paint);
  // }
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    try {
      sprite = await game.loadSprite('teckel_default.png');
      // size = sprite!.srcSize;
       print("Sprite Objet Négatif. Size: $size.");
    } catch (e) {
      print("Error loading Bad Object sprite: $e");
    }

    add(RectangleHitbox());
  }

  @override
  void onDragUpdate(DragUpdateEvent event) { // gestion du drag
    super.onDragUpdate(event);
    position.x = (position.x + event.localDelta.x).clamp(0, game.width);
  }

  void moveBy(double dx) {
    add(MoveToEffect( // Effects => batte animée vers une nouvelle position
      // clamp permet de faire sortir la batte de l'écran à mi-chemin (utile pour les smartphones)
      Vector2((position.x + dx).clamp(0, game.width), position.y), 
      EffectController(duration: 0.1),
    ));
  }
}
