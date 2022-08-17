import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_web3_games/core/pubs/improvedScrolling/simple_intance.dart';
import 'package:flutter_web3_games/core/router.dart';
import 'package:flutter_web3_games/view/widgets/app_dialog.dart';
import 'package:flutter_web3_games/view/widgets/base_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qlevar_router/qlevar_router.dart';

import '../../core/gen/assets.gen.dart';
import '../../core/pubs/improvedScrolling/MMB_scroll_cursor_activity.dart';
import '../../core/pubs/improvedScrolling/config.dart';
import '../../core/pubs/improvedScrolling/custom_scroll_cursor.dart';
import '../../core/pubs/improvedScrolling/global_scroll_behovior.dart';
import '../../logic/games/rock_paper/rock_paper_controller.dart';
import 'components/game_card.dart';

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
        child: AnimationLimiter(
          child: ListView.builder(
    physics:
    BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
    itemCount: 1,
    itemBuilder: (BuildContext c, int i) {
    return AnimationConfiguration.staggeredList(
      position: i,
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
          child: GameCard(
            onTap: () {
              AppDialogs().showOnlineOrOfflinePlayDialog(context,
                  onOfflinePressed: () async {
                    Navigator.pop(context);
                    Get.find<RockPaperController>().offline = true;
                    await QR.to(ROCK_PAPER_OFFLINE_ROUET);
                  }, onOnlinePressed: () async {
                    Get.find<RockPaperController>().offline = false;
                    Navigator.pop(context);
                    await QR.to(ROCK_PAPER_ONLINE_ROUET);
                  });
            },
            gameLogo: Assets.images.icRockPaper,
            gameBanner: Assets.images.rockPaperBanner,
          ),
        ),
      ),
    );
    })
        ),
      ),
    );
  }
}
