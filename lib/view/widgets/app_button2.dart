import 'package:flutter_web3_games/core/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppButton extends StatefulWidget {
  String? text;
  Widget? textWidget;
  double? minWidth;
  Function? onPressed;
  AppButton({Key? key, this.text, this.minWidth, this.textWidget, this.onPressed}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AppButtonState();
  }
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return isAppStyleMaterial()
        ? MaterialButton(
            minWidth: widget.minWidth,
            onPressed: () => widget.onPressed?.call(),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: widget.text != null ? Text(
                widget.text ?? "",
                style: TextStyle(
                    fontSize:
                    Theme.of(context).textTheme.bodyText1!.fontSize! + 2),
              ) : widget.textWidget,
            ),
            color: Theme.of(context).buttonTheme.colorScheme?.background ?? Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          )
        : CupertinoButton(
      onPressed: () => widget.onPressed?.call(),
            child:  widget.text != null ? Text(
              widget.text ?? "",
              style: TextStyle(
                  fontSize:
                  Theme.of(context).textTheme.bodyText1!.fontSize! + 2),
            ) : widget.textWidget ?? Text(""),
          );
  }
}
