

import 'package:flutter/cupertino.dart';

import 'MMB_scroll_cursor_activity.dart';
import 'config.dart';
import 'custom_scroll_cursor.dart';

class ImprovedScroller extends StatefulWidget{

  Widget child;
  ScrollController scrollController;

  ImprovedScroller({Key? key, required this.child, required this.scrollController}) : super(key: key);


  @override
  State<StatefulWidget> createState() {
    return _ImprovedScrollerState();
  }
}

class _ImprovedScrollerState extends State<ImprovedScroller>{

    @override
    Widget build(BuildContext context) {
      return ImprovedScrolling(
        scrollController: widget.scrollController,
        enableMMBScrolling: true,
        enableKeyboardScrolling: true,
        enableCustomMouseWheelScrolling: true,
        mmbScrollConfig: const MMBScrollConfig(
            customScrollCursor: DefaultCustomScrollCursor(),
            autoScrollDelay: Duration(milliseconds: 60)),
        keyboardScrollConfig: KeyboardScrollConfig(
          homeScrollDurationBuilder:
              (currentScrollOffset, minScrollOffset) {
            return const Duration(milliseconds: 100);
          },
          endScrollDurationBuilder:
              (currentScrollOffset, maxScrollOffset) {
            return const Duration(milliseconds: 2000);
          },
        ),
        customMouseWheelScrollConfig:
        const CustomMouseWheelScrollConfig(
          scrollAmountMultiplier: 4.0,
          scrollDuration: Duration(milliseconds: 350),
        ),
        child: widget.child,
      );
    }
}