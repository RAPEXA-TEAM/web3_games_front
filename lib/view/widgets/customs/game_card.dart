import 'package:flutter/material.dart';
import 'package:flutter_web3_games/core/global_ex.dart';
import 'package:flutter_web3_games/view/games/ext.dart';
import 'package:flutter_web3_games/view/widgets/customs/vertical_parallax.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/models/games/models/game.dart';

class GameCard extends StatelessWidget {
  const GameCard({
    Key? key,
    required this.game,
  });

  final Game game;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.gameCardWidgetWidth(),
      height: context.gameCardWidgetHeight(),
      child: Card(
        elevation: 15,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            VerticalParallax(
                scrollable: Scrollable.of(context)!,
                child: Image(
                  image: game.image,
                  fit: BoxFit.fitWidth,
                ),
              ),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.6, 1],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Label extends StatelessWidget {
  const _Label({required this.game});

  final Game game;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                game.name,
                style: GoogleFonts.workSans(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          child: const CircleAvatar(
            backgroundColor: Color(0xFF1788DA),
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          onTap: () {},
        ),
      ],
    );
  }
}
