// import 'package:animations/animations.dart';
// import 'package:flutter_web3_games/view/games/rock_paper/rock_paper_offline.dart';
// import 'package:flutter_web3_games/view/games/rock_paper/rock_paper_match_finder.dart';
// import 'package:flutter_web3_games/view/games/rock_paper/rock_paper_scoreboard.dart';
// import 'package:flutter_web3_games/view/home/home_page.dart';
// import 'package:flutter_web3_games/view/login/login_send_otp.dart';
// import 'package:flutter_web3_games/view/settings/settings_page.dart';
// import 'package:flutter/material.dart';
//
// import '../view/splash/splash_page.dart';
//
// const String SPLASH_ROUTE = "/splash";
// const String HOME_ROUTE = "/home";
// const String GAMES_ROUTE = "/games";
// const String SIGNIN_ROUTE = "/signin";
// const String SIGNUP_ROUTE = "/signup";
// const String VERIFY_LOGIN_OTP = "/loginVerifyOtp";
// const String VERIFY_REGISTER_OTP_ROUTE = "/registerVerifyOtp";
// const String VERIFY_CHANGE_PASSWORD_OTP_ROUTE = "/changePasswordOtpVerify";
// const String CHANGE_PASSWORD_EMAIL_ROUTE = "/changePasswordEmail";
// const String CHANGE_PASSWORD_OTP_ROUTE = "/changePasswordOtp";
// const String SETTINGS_ROUTE = "/settings";
// const String ROCK_PAPER_ROUET = "/rockPaper";
// const String ROCK_PAPER_MATHFINDER_ROUTE = "/rockPaperMathFinder";
// const String ROCK_PAPER_SCOREBOARD_ROUTE = "/rockPaperScoreboard";
//
// class AppRouter {
//   static SharedAxisTransition globalTransaction(
//       context, animation, secondaryAnimation, child) {
//     return SharedAxisTransition(
//       fillColor: Colors.black,
//       transitionType: SharedAxisTransitionType.scaled,
//       animation: animation,
//       secondaryAnimation: secondaryAnimation,
//       child: child,
//     );
//   }
//   static SharedAxisTransition globalTransactionSlide(
//       context, animation, secondaryAnimation, child) {
//     return SharedAxisTransition(
//       fillColor: Colors.black,
//       transitionType: SharedAxisTransitionType.horizontal,
//       animation: animation,
//       secondaryAnimation: secondaryAnimation,
//       child: child,
//     );
//   }
//
//   Route generateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case SPLASH_ROUTE:
//       // return PageTransition(child: SplashScreen(), type: PUSH_ANIMATION);
//         return PageRouteBuilder(
//           pageBuilder: (context, animation, secondaryAnimation) {
//             return SplashPage();
//           },
//           transitionsBuilder: (context, animation, secondaryAnimation, child) {
//             return globalTransaction(
//                 context, animation, secondaryAnimation, child);
//           },
//         );
//       case SETTINGS_ROUTE:
//         return PageRouteBuilder(
//           pageBuilder: (context, animation, secondaryAnimation) {
//             return SettingsPage();
//           },
//           transitionsBuilder: (context, animation, secondaryAnimation, child) {
//             return globalTransaction(
//                 context, animation, secondaryAnimation, child);
//           },
//         );
//       case SIGNIN_ROUTE:
//         return PageRouteBuilder(
//           pageBuilder: (context, animation, secondaryAnimation) {
//             return LoginSendOtpPage();
//           },
//           transitionsBuilder: (context, animation, secondaryAnimation, child) {
//             return globalTransaction(
//                 context, animation, secondaryAnimation, child);
//           },
//         );
//       case HOME_ROUTE:
//         return PageRouteBuilder(
//           pageBuilder: (context, animation, secondaryAnimation) {
//             return HomePage();
//           },
//           transitionsBuilder: (context, animation, secondaryAnimation, child) {
//             return globalTransaction(
//                 context, animation, secondaryAnimation, child);
//           },
//         );
//       case ROCK_PAPER_ROUET:
//         return PageRouteBuilder(
//           pageBuilder: (context, animation, secondaryAnimation) {
//             return RockPaperPage();
//           },
//           transitionsBuilder: (context, animation, secondaryAnimation, child) {
//             return globalTransaction(
//                 context, animation, secondaryAnimation, child);
//           },
//         );
//       case ROCK_PAPER_MATHFINDER_ROUTE:
//         return PageRouteBuilder(
//           pageBuilder: (context, animation, secondaryAnimation) {
//             return RockPaperMatchFinderPage();
//           },
//           transitionsBuilder: (context, animation, secondaryAnimation, child) {
//             return globalTransaction(
//                 context, animation, secondaryAnimation, child);
//           },
//         );
//       case ROCK_PAPER_SCOREBOARD_ROUTE:
//         return PageRouteBuilder(
//           pageBuilder: (context, animation, secondaryAnimation) {
//             return RockPaperScoreboardPage();
//           },
//           transitionsBuilder: (context, animation, secondaryAnimation, child) {
//             return globalTransaction(
//                 context, animation, secondaryAnimation, child);
//           },
//         );
//       default:
//         return PageRouteBuilder(
//           pageBuilder: (context, animation, secondaryAnimation) {
//             return SplashPage();
//           },
//           transitionsBuilder: (context, animation, secondaryAnimation, child) {
//             return globalTransaction(
//                 context, animation, secondaryAnimation, child);
//           },
//         );
//     }
//   }
// }

import 'package:flutter_web3_games/view/games/rock_paper/rock_paper_offline.dart' deferred as rockPaperOffline;
import 'package:flutter_web3_games/view/games/rock_paper/rock_paper_online.dart' deferred as rockPaperOnline;
import 'package:flutter_web3_games/view/games/rock_paper/rock_paper_match_finder.dart' deferred as rockPaperMatchFinder;
import 'package:flutter_web3_games/view/games/rock_paper/rock_paper_scoreboard.dart' deferred as rockPaperScoreboard;
import 'package:flutter_web3_games/view/home/home_page.dart' deferred as homePage;
import 'package:flutter_web3_games/view/settings/settings_page.dart' deferred as settingsPage;
import 'package:flutter_web3_games/view/login/login_page.dart' deferred as login;
import 'package:qlevar_router/qlevar_router.dart';

import '../view/splash/splash_page.dart' deferred as splashPage;

const String SPLASH_ROUTE = "/";
const String HOME_ROUTE = "/home";
const String GAMES_ROUTE = "/games";
const String LOGIN_ROUTE = "/login";
const String VERIFY_LOGIN_OTP = "/loginVerifyOtp";
const String VERIFY_REGISTER_OTP_ROUTE = "/registerVerifyOtp";
const String VERIFY_CHANGE_PASSWORD_OTP_ROUTE = "/changePasswordOtpVerify";
const String CHANGE_PASSWORD_EMAIL_ROUTE = "/changePasswordEmail";
const String CHANGE_PASSWORD_OTP_ROUTE = "/changePasswordOtp";
const String SETTINGS_ROUTE = "/settings";
const String ROCK_PAPER_OFFLINE_ROUET = "/rockPaperOffline";
const String ROCK_PAPER_ONLINE_ROUET = "/rockPaperOnline";
const String ROCK_PAPER_MATHFINDER_ROUTE = "/rockPaperMathFinder";
const String ROCK_PAPER_SCOREBOARD_ROUTE = "/rockPaperScoreboard";

class DeferredLoader extends QMiddleware {
  final Future<dynamic> Function() loader;

  DeferredLoader(this.loader);
  @override
  Future onEnter() async {
    await loader();
  }
}

class Routes {
  static final routes = <QRoute>[
    QRoute(
      path: SPLASH_ROUTE,
      builder: () => splashPage.SplashPage(),
      middleware: [
        DeferredLoader(splashPage.loadLibrary),
      ],
    ),
    QRoute(
      path: HOME_ROUTE,
      builder: () => homePage.HomePage(),
      middleware: [
        DeferredLoader(homePage.loadLibrary),
      ],
    ),
    QRoute(
      path: LOGIN_ROUTE,
      builder: () => login.LoginPage(),
      middleware: [
        DeferredLoader(login.loadLibrary),
      ],
    ),
    QRoute(
      path: SETTINGS_ROUTE,
      builder: () => settingsPage.SettingsPage(),
      middleware: [
        DeferredLoader(settingsPage.loadLibrary),
      ],
    ),
    QRoute(
      path: ROCK_PAPER_OFFLINE_ROUET,
      builder: () => rockPaperOffline.RockPaperPageOffline(),
      middleware: [
        DeferredLoader(rockPaperOffline.loadLibrary),
      ],
    ),
    QRoute(
      path: ROCK_PAPER_ONLINE_ROUET,
      builder: () => rockPaperOnline.RockPaperPageOnline(),
      middleware: [
        DeferredLoader(rockPaperOnline.loadLibrary),
      ],
    ),
    QRoute(
      path: ROCK_PAPER_MATHFINDER_ROUTE,
      builder: () => rockPaperMatchFinder.RockPaperMatchFinderPage(),
      middleware: [
        DeferredLoader(rockPaperMatchFinder.loadLibrary),
      ],
    ),
    QRoute(
      path: ROCK_PAPER_SCOREBOARD_ROUTE,
      builder: () => rockPaperScoreboard.RockPaperScoreboardPage(),
      middleware: [
        DeferredLoader(rockPaperScoreboard.loadLibrary),
      ],
    ),
  ];
}

