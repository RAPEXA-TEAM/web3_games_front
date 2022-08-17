import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:flutter_web3_games/core/gen/assets.gen.dart';
import 'package:flutter_web3_games/core/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web3_games/logic/games/rock_paper/rock_paper_controller.dart';
import 'package:flutter_web3_games/view/widgets/base_page.dart';
import 'package:get/get.dart';
import 'package:qlevar_router/qlevar_router.dart';

class RockPaperPageOffline extends StatefulWidget {
  const RockPaperPageOffline({Key? key}) : super(key: key);


  @override
  _RockPaperPageOfflineState createState() => _RockPaperPageOfflineState();
}

class _RockPaperPageOfflineState extends State<RockPaperPageOffline> {
  String playerSelection = "Nothing";
  String gameResult = "Press any of these three buttons";
  String computerSelection = "Nothing";
  int playerWins = 0;
  int computerWins = 0;
  int? round;

  late ConfettiController _controllerCenter;
  late ConfettiController _controllerCenterTop;


  @override
  void initState() {
    super.initState();
    _controllerCenter = ConfettiController(duration: const Duration(seconds: 1));
    _controllerCenterTop = ConfettiController(duration: const Duration(seconds: 10));
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    _controllerCenterTop.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(_images['Rock']);
    return BasePage(
      appBar: AppBar(
        title: Text("Rock Paper Scissors"),
      ),
      body: GetBuilder<RockPaperController>(
            autoRemove: false,
            builder: (controller) {
              if(round == null){
                round = controller.user.gameLength;
              }
          return round == 0 ?  finalWhoWin() : SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(height: 20),
                Column(
                  children: [
                    Text(
                      "Computer",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    RotatedBox(
                    quarterTurns: 2,
                    child:
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: _getImage(_images[computerSelection].toString()),
                    )),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: ConfettiWidget(
                        child: _buildGameStateButton(gameResult),
                        confettiController: _controllerCenter,
                        blastDirectionality: BlastDirectionality
                            .explosive, // don
                        gravity: 1,
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: _getImage(_images[playerSelection].toString()),
                    ),
                    Text(controller.user.username!, style: TextStyle(fontWeight: FontWeight.bold),)
                  ],
                ),
                SizedBox(height: 50),
                Text(
                  "Round $round",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    InkWell(
                      onTap: () {
                        setState(() {
                          round = round! - 1;
                          computerSelection = computerMove();
                          playerSelection = "Rock";
                          gameResult = whoWins("$playerSelection", "$computerSelection");
                        });
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Assets.images.rock.image(height: 80, width: 60, fit: BoxFit.fill),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          round = round! - 1;
                          computerSelection = computerMove();
                          playerSelection = "Paper";
                          gameResult = whoWins("$playerSelection", "$computerSelection");
                        });
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Assets.images.paper.image(height: 80, width: 60, fit: BoxFit.fill),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          round = round! - 1;
                          computerSelection = computerMove();
                          playerSelection = "Scissors";
                          gameResult = whoWins("$playerSelection", "$computerSelection");
                        });
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Assets.images.scissors.image(height: 80, width: 60, fit: BoxFit.fill),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        }),
    );
  }

  TextButton scoreBoard(BuildContext context) {
    return TextButton(
      child: Text("Scoreboard"),
      onPressed: () {
        QR.to(ROCK_PAPER_SCOREBOARD_ROUTE);
      },
    );
  }


  String computerMove() {
    Random rand = new Random();
    int move = rand.nextInt(3);
    String? computerSelection;

    switch (move) {
      case 0:
        debugPrint("Rock");
        computerSelection = "Rock";
        break;
      case 1:
        debugPrint("Paper");
        computerSelection = "Paper";
        break;
      case 2:
        debugPrint("Scissors");
        computerSelection = "Scissors";
        break;
      default:
        break;
    }
    return computerSelection!;
  }

  String whoWins(String playerMove, String computerMove) {
    if (playerMove == computerMove) {
      debugPrint("Tie");
      return "Tie";
    } else if (playerMove == "Rock" && computerMove == "Scissors") {
      debugPrint("You Win!");
      playerWins++;
      _controllerCenter.play();
      Future.delayed(Duration(seconds: 1), () {
        _controllerCenter.stop();
      });
      return "You Win!";
    } else if (playerMove == "Scissors" && computerMove == "Paper") {
      debugPrint("You Win!");
      playerWins++;
      _controllerCenter.play();
      Future.delayed(Duration(seconds: 1), () {
        _controllerCenter.stop();
      });
      return "You Win!";
    } else if (playerMove == "Paper" && computerMove == "Rock") {
      debugPrint("You Win!");
      playerWins++;
      _controllerCenter.play();
      Future.delayed(Duration(seconds: 1), () {
        _controllerCenter.stop();
      });
      return "You Win!";
    } else {
      debugPrint("Computer Wins!");
      computerWins++;
      return "Computer Wins!";
    }
  }

  Widget finalWhoWin(){
    if(playerWins > computerWins){
      _controllerCenterTop.play();
      return Center(child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
                confettiController: _controllerCenterTop,
                blastDirectionality: BlastDirectionality
                    .explosive, // lot of particles at once
                gravity: 1,
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: ConfettiWidget(
                confettiController: _controllerCenterTop,
                blastDirectionality: BlastDirectionality
                    .explosive, // lot of particles at once
                gravity: 1,
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: ConfettiWidget(
                confettiController: _controllerCenterTop,
                blastDirectionality: BlastDirectionality
                    .explosive, // lot of particles at once
                gravity: 1,
            ),
          ),
          Center(child: _buildGameStateButton("You Win!"))
        ],
      ));
    }else if(playerWins < computerWins){
      return Center(child: _buildGameStateButton("Computer Wins!"));
    }else{
      return Center(child: _buildGameStateButton("Tie"));
    }
  }

  String movePlayer(String? selection) {
    String? playerSelection;

    switch (selection) {
      case "R":
        debugPrint("Rock");
        playerSelection = "Rock";
        break;
      case "P":
        debugPrint("Paper");
        playerSelection = "Paper";

        break;
      case "S":
        debugPrint("Scissors");
        playerSelection = "Scissors";

        break;
      default:
        debugPrint("Quit");
        break;
    }
    return playerSelection!;
  }


  Map<String, String> _images = {
    "Rock": "assets/images/rock.png",
    "Paper": "assets/images/paper.png",
    "Scissors": "assets/images/scissors.png",
    "Nothing": "assets/images/ic_start_rock_paper.png",
  };

  Image _getImage(String image) => Image.asset(
        image,
        height: 120,
        width: 100,
        fit: BoxFit.fill,
      );

  Widget _buildGameStateButton(String gameResult){
    switch(gameResult){
      case "You Win!":
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: const BorderRadius.all(
              Radius.circular(999),
            ),
            color: Colors.greenAccent,
            boxShadow: [
              BoxShadow(
                  color: Colors.greenAccent,
                  spreadRadius: 2,
                  blurRadius: 10,
                  blurStyle: BlurStyle.normal),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
                "$gameResult",style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 25)),
          ),
        );
      case "Computer Wins!":
      case "Player 2 Wins!":
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: const BorderRadius.all(
              Radius.circular(999),
            ),
            color: Colors.redAccent,
            boxShadow: [
              BoxShadow(
                  color: Colors.redAccent,
                  spreadRadius: 2,
                  blurRadius: 10,
                  blurStyle: BlurStyle.normal),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
                "$gameResult",style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 25)),
          ),
        );
      case "Tie":
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: const BorderRadius.all(
              Radius.circular(999),
            ),
            color: Colors.yellowAccent,
            boxShadow: [
              BoxShadow(
                  color: Colors.yellowAccent,
                  spreadRadius: 2,
                  blurRadius: 10,
                  blurStyle: BlurStyle.normal),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
                "$gameResult",style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black54, fontSize: 25)),
          ),
        );
        default:
          return Container();
    }
  }

}
