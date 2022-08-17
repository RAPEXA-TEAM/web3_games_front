import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/consts.dart';

class AppSwitch extends StatefulWidget {
  const AppSwitch({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AppSwitchState();
  }
}

class _AppSwitchState extends State<AppSwitch> {
  @override
  Widget build(BuildContext context) {
    return isAppStyleMaterial()
        ? Switch(value: true, onChanged: (value) {})
        : CupertinoSwitch(value: true, onChanged: (value) {});
  }
}
