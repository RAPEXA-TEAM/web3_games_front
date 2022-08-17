import 'package:flutter/material.dart';
import 'package:flutter_web3_games/core/gen/assets.gen.dart';
import 'dart:async';

import 'package:flutter_web3_games/core/router.dart';
import 'package:flutter_web3_games/data/datasources/local/sharedStore.dart';
import 'package:qlevar_router/qlevar_router.dart';

  

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(milliseconds: 400), () {
      setState(() {
        _a = true;
      });
    });
    Timer(Duration(milliseconds: 400), () {
      setState(() {
        _b = true;
      });
    });
    Timer(Duration(milliseconds: 1300), () {
      setState(() {
        _c = true;
      });
    });
    Timer(Duration(milliseconds: 1700), () {
      setState(() {
        _e = true;
      });
    });
    Timer(Duration(milliseconds: 3400), () {
      setState(() {
        _d = true;
      });
    });
    Timer(Duration(milliseconds: 3850), () {
      setState(() {
        if(SharedStore.getRegisteredWalletAddress().isNotEmpty){
          QR.to(HOME_ROUTE);
        }else{
          QR.to(LOGIN_ROUTE);
        }
      });
    });
  }

  bool _a = false;
  bool _b = false;
  bool _c = false;
  bool _d = false;
  bool _e = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _h = MediaQuery.of(context).size.height;
    double _w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: _d ? 900 : 2500),
              curve: _d ? Curves.fastLinearToSlowEaseIn : Curves.elasticOut,
              height: _d
                  ? 0
                  : _a
                  ? _h / 2
                  : 20,
              width: 20,
              // color: Colors.deepPurpleAccent,
            ),
            AnimatedContainer(
              duration: Duration(

                  seconds: _d
              ? 1
                  : _c
              ? 2
                  : 0),
              curve: Curves.fastLinearToSlowEaseIn,
              height: _d
                  ? _h
                  : _c
                  ? 80
                  : 20,
              width: _d
                  ? _w
                  : _c
                  ? 200
                  : 20,
              decoration: BoxDecoration(
                  color: _b ? Colors.white : Colors.transparent,
                  // shape: _c? BoxShape.rectangle : BoxShape.circle,
                  borderRadius:
                  _d ? BorderRadius.only() : BorderRadius.circular(30)),
              child: Center(
                child: _e
                    ? Assets.images.icSplashLogo.image(height: 90, width: 90)
                // AnimatedTextKit(
                //   totalRepeatCount: 1,
                //   animatedTexts: [
                //     FadeAnimatedText(
                //       'Web3 Games',
                //       duration: Duration(milliseconds: 1700),
                //       textStyle: TextStyle(
                //         fontSize: 30,
                //         fontWeight: FontWeight.w700,
                //       ),
                //     ),
                //   ],
                // )
                    : SizedBox(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
