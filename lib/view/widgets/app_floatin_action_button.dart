import 'package:flutter_web3_games/core/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppFloatingActionButton extends StatefulWidget {
  Icon icon;
  Function? onPressed;
  double? marginTop;
  double? marginRight;
  double? marginBottom;
  double? marginLeft;

  AppFloatingActionButton(
      {Key? key,
      required this.icon,
      this.onPressed,
      this.marginBottom,
      this.marginLeft,
      this.marginRight,
      this.marginTop})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AppFloatingActionButtonState();
  }
}

class _AppFloatingActionButtonState extends State<AppFloatingActionButton> {
  @override
  Widget build(BuildContext context) {
    return isAppStyleMaterial()
        ? FloatingActionButton(
            onPressed: () => widget.onPressed?.call(), child: widget.icon)
        : InkWell(
      onTap: () => widget.onPressed?.call(),
          child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 5,
                  ),],
                  color: Theme.of(context).buttonTheme.colorScheme?.background ?? Colors.green,
                  borderRadius: BorderRadius.circular(10)),
              width: 50,
              height: 50,
              child: widget.icon,
            ),
        );
  }
}
