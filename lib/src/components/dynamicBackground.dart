import 'package:flame/components.dart';
import '../topteckel.dart';


class DynamicBackground extends Component with HasGameReference<TopTeckel> {
  List<String> backgrounds = [
    'decor_default.png',
  ];
  int currentIndex = 0;
  late SpriteComponent sprite;

  @override
  Future<void> onLoad() async { // Future permet au programme de continuer de fonctionner pendant que la tâche s'effectue en arrière-plan 
    sprite = SpriteComponent()
      ..sprite = await Sprite.load(backgrounds[currentIndex])
      ..size = Vector2(game.width, game.height)
      ..position = Vector2.zero();
    add(sprite);
  }

  Future<void> changeBackground() async {
    currentIndex = (currentIndex + 1) % backgrounds.length;
    sprite.sprite = await game.loadSprite(backgrounds[currentIndex]);
  }
}
