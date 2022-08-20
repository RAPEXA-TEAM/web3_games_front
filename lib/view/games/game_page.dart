import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_web3_games/core/global_ex.dart';
import 'package:flutter_web3_games/core/pubs/improvedScrolling/simple_intance.dart';
import 'package:flutter_web3_games/data/models/games/models/game.dart';
import 'package:flutter_web3_games/view/games/ext.dart';
import 'package:flutter_web3_games/view/widgets/base_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web3_games/view/widgets/customs/game_card.dart';
import '../../core/gen/assets.gen.dart';
import '../widgets/customs/squeeze.dart';
import '../widgets/customs/symbols_overlay.dart';

class GamePage extends StatefulWidget {
  final bool fromHome;

  const GamePage({
    Key? key,
    this.fromHome = false,
  }) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageStater();
}

class _GamePageStater extends State<GamePage>
    with SingleTickerProviderStateMixin {
  final controller = ScrollController();

  List<Game> games = [
    Game(
      name: 'Cyberpunk 2077',
      image: AssetImage(Assets.images.rockPaperBanner.path),
    ),
    Game(
      name: 'Cyberpunk 2077',
      image: AssetImage(Assets.images.cyberpunk.path),
    ),
    Game(
      name: 'Ghost of Tsushima',
      image: AssetImage(Assets.images.ghostOfTsushima.path),
    ),
    Game(
      name: 'The Last of Us Part II',
      image: AssetImage(Assets.images.theLastOfUs.path),
    ),
    Game(
      name: 'Deathloop',
      image: AssetImage(Assets.images.deathloop.path),
    ),
    Game(
      name: 'Spider-Man: Miles Morales',
      image: AssetImage(Assets.images.spiderMan.path),
    ),
    Game(
      name: 'Horizon Forbidden West',
      image: AssetImage(Assets.images.horizon.path),
    ),
  ];

  EdgeInsets _padding = EdgeInsets.zero;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
        appBar: !widget.fromHome
            ? AppBar(
                title: Text("Games"),
              )
            : null,
        body: ImprovedScroller(
          scrollController: controller,
          child: ListView.builder(
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            controller: controller,
            padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
            // separatorBuilder: (_, __) => const SizedBox.shrink(),
            itemCount: games.length,
            itemBuilder: (context, index) {
              return SizedBox(
                width: context.gameCardWidgetWidth(),
                height: context.gameCardWidgetHeight(),
                child: AnimationConfiguration.staggeredList(
                  position: index,
                  delay: Duration(milliseconds: 100),
                  child: SlideAnimation(
                    duration: Duration(milliseconds: 2500),
                    curve: Curves.fastLinearToSlowEaseIn,
                    horizontalOffset: 30,
                    verticalOffset: 300.0,
                    child: FlipAnimation(
                      duration: Duration(milliseconds: 3000),
                      curve: Curves.fastLinearToSlowEaseIn,
                      flipAxis: FlipAxis.y,
                      child: Stack(
                          children: [
                            Squeeze(
                              squeeze: 15,
                              onSqueeze: (squeeze) {
                                // setState(() {
                                //   _padding = EdgeInsets.only(top: 20);
                                // });
                              },
                              child: Center(child: GameCard(game: games[index])),
                            ),
                            if (index.isOdd)
                              const SymbolsOverlay(
                                  type: SymbolsOverlayType.rectangleAndCross)
                            else
                              const SymbolsOverlay(
                                  type: SymbolsOverlayType.circleAndTriangle),
                          ],
                        ),
                      ),
                    ),
                ),
              );
            },
          ),
        ));
  }
}
