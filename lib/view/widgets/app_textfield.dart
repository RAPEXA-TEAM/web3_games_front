import 'package:flutter_web3_games/core/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  double? maxWidth;
  TextEditingController? controller;
  String? hintText;
  String? text;
  TextInputType? textInputType;
  Function(String)? onTextChanged;

  AppTextField({Key? key, this.onTextChanged, this.textInputType, this.maxWidth, this.controller, this.hintText, this.text}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AppTextField();
  }
}

class _AppTextField extends State<AppTextField> {


  @override
  void initState() {
    if(widget.text != null){
      widget.controller ??= TextEditingController(text: widget.text);
    }
    widget.controller?.text = widget.text!;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return isAppStyleMaterial()
        ? Align(
            alignment: Alignment.center,
            child: Container(
              constraints:
                  BoxConstraints(maxWidth: widget.maxWidth ?? double.infinity),
              child: TextField(
                onChanged: (value) => widget.onTextChanged?.call(value),
                keyboardType: widget.textInputType,
                textInputAction: TextInputAction.next,
                controller: widget.controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: widget.hintText,
                ),
              ),
            ),
          )
        : Align(
            alignment: Alignment.center,
            child: Container(
              constraints:
                  BoxConstraints(maxWidth: widget.maxWidth ?? double.infinity),
              child: CupertinoTextField(
                onChanged: (value) => widget.onTextChanged?.call(value),
                keyboardType: widget.textInputType,
                textInputAction: TextInputAction.next,
                controller: widget.controller,
              ),
            ),
          );
  }
}
