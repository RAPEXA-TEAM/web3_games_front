// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
// import 'package:flutter_web3_games/core/gen/assets.gen.dart';
// import 'package:flutter/material.dart';
// import '../ext.dart';
//
// class GameCard extends StatelessWidget {
//
//   final AssetGenImage gameLogo;
//   final AssetGenImage gameBanner;
//   final Function? onTap;
//
//   GameCard({Key? key, required this.gameLogo, required this.gameBanner, this.onTap}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Center(
//             child: InkWell(
//               onTap: () {
//                 onTap?.call();
//               },
//               child: SizedBox(
//               width: context.gameCardWidgetWidth(),
//               height: context.gameCardWidgetHeight(),
//               child: Card(
//                 color: Colors.white,
//                 elevation: 5,
//                 shape: const RoundedRectangleBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(10))),
//                 clipBehavior: Clip.antiAlias,
//                 child: Row(
//                   mainAxisSize: MainAxisSize.max,
//                   children: [
//                     Flexible(
//                       flex: 2,
//                       fit: FlexFit.loose,
//                       child: SizedBox(
//                         width: double.infinity,
//                         height: context.gameCardWidgetHeight(),
//                         child: Image.asset(gameLogo.path, fit: BoxFit.fill),
//                       ),
//                     ),
//                     Flexible(
//                       flex: 5,
//                       fit: FlexFit.tight,
//                       child: SizedBox(
//                         height: context.gameCardWidgetHeight(),
//                         child: Image.asset(gameBanner.path, fit: BoxFit.fill),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//       ),
//     );
//   }
// }
