import 'package:flutter/material.dart';
import 'package:flutter_web3_games/core/gen/assets.gen.dart';
import 'package:flutter_web3_games/core/pubs/improvedScrolling/simple_intance.dart';
import 'package:flutter_web3_games/data/models/getAllRockPaper_rp.dart';
import 'package:flutter_web3_games/logic/games/rock_paper/rock_paper_controller.dart';
import 'package:flutter_web3_games/view/widgets/app_floatin_action_button.dart';
import 'package:get/get.dart';

class RockPaperMatchFinderPage extends StatefulWidget {
  const RockPaperMatchFinderPage({Key? key}) : super(key: key);

  @override
  State createState() => _RockPaperMatchFinderPageState();
}

class _RockPaperMatchFinderPageState extends State<RockPaperMatchFinderPage> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Get.find<RockPaperController>().getAllRockPaperGame();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rock Paper Match Finder'),
      ),
      body: GetBuilder<RockPaperController>(
        builder: (controller) {
          return ImprovedScroller(
              child: SingleChildScrollView(
                controller: scrollController,
                child: ListView.builder(
                  itemCount: controller.allRockPaperGames.length,
                  itemBuilder: (context, index) {
                    return _buildRockPaperGameCard(controller.allRockPaperGames[index]);
                  },
                ),
              ),
              scrollController: scrollController);
        },
      ),
      floatingActionButton: AppFloatingActionButton(
        icon: Icon(Icons.add),
        onPressed: () {
          print('add');
        },
      ),
    );
  }

  Widget _buildRockPaperGameCard(RockPaperGame rockPaperGame) {
    return Padding(
      padding: EdgeInsets.all(25),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: EdgeInsets.all(25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Assets.images.icPlayer.image(height: 50, width: 50),
                  SizedBox(height: 10),
                  Text(rockPaperGame.players.split(",")[0])
                ],
              ),
              Column(
                children: [
                  Assets.images.icDepositEther.image(height: 50, width: 50),
                  SizedBox(height: 10),
                  Text(rockPaperGame.value)
                ],
              ),
              Column(
                children: [
                  Assets.images.icThree.image(height: 50, width: 50),
                  SizedBox(height: 10),
                  Text("Rounds")
                ],
              ),
              Column(
                children: [
                  Assets.images.icStartRockPaper.image(height: 50, width: 50),
                  SizedBox(height: 10),
                  Text("Start Game")
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
