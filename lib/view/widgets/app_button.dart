
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppButton extends StatefulWidget {
  String? text;
  Widget? textWidget;
  double? width;
  double widthIfNull = 130;
  double? height;
  double heightIfNull = 50;
  Function? onPressed;
  AppButton({Key? key, this.text, this.width, this.height, this.textWidget, this.onPressed}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AppButtonState();
  }
}

class _AppButtonState extends State<AppButton> {

  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? widget.widthIfNull,
      height: widget.height ?? widget.heightIfNull,
      child: Center(
        child: InkWell(
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onHighlightChanged: (value) {
            setState(() {
              isTapped = value;
            });
          },
          onTap: () {
            widget.onPressed?.call();
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            curve: Curves.fastLinearToSlowEaseIn,
            height: isTapped ? (widget.heightIfNull - 5) : widget.heightIfNull,
            width: isTapped ? (widget.widthIfNull - 10) : widget.widthIfNull,
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 30,
                  offset: Offset(3, 7),
                ),
              ],
            ),
            child: widget.textWidget ?? Center(
              child: Text(
                widget.text ?? "",
                style: TextStyle(
                  color: Colors.black.withOpacity(0.7),
                  fontWeight: FontWeight.w500,
                  fontSize: 19,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
