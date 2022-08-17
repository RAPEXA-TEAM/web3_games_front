import 'package:flutter_web3_games/core/consts.dart';
import 'package:flutter_web3_games/data/datasources/local/sharedStore.dart';
import 'package:flutter_web3_games/view/widgets/app_floatin_action_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BasePage extends StatefulWidget {
  AppBar? appBar;
  Widget body;
  AppFloatingActionButton? floatingActionButton;

  BasePage({Key? key, this.appBar, required this.body, this.floatingActionButton}) : super(key: key);

  @override
  State<StatefulWidget> createState() => BasePageStater();
}

class BasePageStater extends State<BasePage> {
  @override
  Widget build(BuildContext context) {
    return AnimatedTheme(
      data: Theme.of(context),
      child: isAppStyleMaterial()
          ? Scaffold(
              appBar: widget.appBar,
              body: widget.body,
              floatingActionButton: widget.floatingActionButton,
            )
          : CupertinoPageScaffold(
              navigationBar: widget.appBar != null
                  ? CupertinoNavigationBar(
                      brightness: SharedStore.getThemeBrightness() == 1
                          ? Brightness.light
                          : Brightness.dark,
                      middle: Stack(
                        children: [
                          Center(child: widget.appBar?.title),
                          ..._buildCupertinoAppBarActions(
                              widget.appBar?.actions ?? [])
                        ],
                      ),
                    )
                  : null,
              child: widget.floatingActionButton == null ? widget.body : Stack(
                children: [
                 Positioned(
                    right: widget.floatingActionButton!.marginRight,
                    left: widget.floatingActionButton!.marginLeft,
                    top: widget.floatingActionButton!.marginTop,
                    bottom: widget.floatingActionButton!.marginBottom,
                    child: widget.floatingActionButton!,
                 ),
                  widget.body,
                ],
              ),
            ),
    );
  }

  List<Widget> _buildCupertinoAppBarActions(List<Widget> actions) {
    List<Widget> result = [];
    for (var i = 0; i < actions.length; i++) {
      result.add(Positioned(child: actions[i], right: i * 30));
      if (i != actions.length - 1) {
        result.add(SizedBox(width: 10));
      }
    }
    return result;
  }
}
