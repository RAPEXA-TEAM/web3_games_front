import 'package:flutter_web3_games/core/gen/colors.gen.dart';
import 'package:flutter_web3_games/data/datasources/local/sharedStore.dart';
import 'package:flutter_web3_games/view/widgets/toasting/overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';


class AppSnackBar{
  static showSuccess(String message){
    showOverlay((context, t) {
      return IosStyleToast(value: t, text: message, toastType: ToastType.success);
    }, key: ValueKey('hello'), duration: Duration(seconds: 4),curve: Curves.ease);
  }
  static showToast(String message){
    showOverlay((context, t) {
      return IosStyleToast(value: t, text: message, toastType: ToastType.none);
    }, key: ValueKey('hello'),duration: Duration(seconds: 4), curve: Curves.ease);
  }
  static showError(String? message){
    if(message != null){
      showOverlay((context, t) {
        return IosStyleToast(value: t, text: message, toastType: ToastType.error);
      }, key: ValueKey('hello'), duration: Duration(seconds: 4),curve: Curves.ease);
    }
  }
  static showListError(List<String> messages){
    for(var message in messages){
      showError(message);
    }
  }
  static void showLoading() {
    if(!EasyLoading.isShow){
      EasyLoading.instance
        ..displayDuration = const Duration(milliseconds: 2000)
        ..indicatorType = EasyLoadingIndicatorType.fadingCircle
        ..loadingStyle = EasyLoadingStyle.dark
        ..indicatorSize = 45.0
        ..radius = 10.0
      // ..progressColor = Colors.yellow
      // ..backgroundColor = Colors.green
      // ..indicatorColor = Colors.yellow
      // ..textColor = Colors.yellow
        ..loadingStyle = SharedStore.getTheme() == "light" ? EasyLoadingStyle.light : EasyLoadingStyle.dark
        ..maskColor = Colors.blue.withOpacity(0.5)
        ..userInteractions = true
        ..maskType = EasyLoadingMaskType.black
        ..dismissOnTap = false
        ..indicatorType = EasyLoadingIndicatorType.wave
        ..animationStyle = EasyLoadingAnimationStyle.scale;
      // EasyLoading.show();
    }
  }
  static void dismissLoading(){
    if(EasyLoading.isShow){
      EasyLoading.dismiss();
    }
  }
}
enum ToastType { success, error, none }


class CustomAnimation extends EasyLoadingAnimation {
  CustomAnimation();

  @override
  Widget buildWidget(
      Widget child,
      AnimationController controller,
      AlignmentGeometry alignment,
      ) {
    return Opacity(
      opacity: controller.value,
      child: RotationTransition(
        turns: controller,
        child: child,
      ),
    );
  }
}

class IosStyleToast extends StatelessWidget {


  final double value;
  final ToastType toastType;

  static final Tween<Offset> tweenOffset =
  Tween<Offset>(begin: Offset(0, 40), end: Offset(0, 0));

  static final Tween<double> tweenOpacity = Tween<double>(begin: 0, end: 1);
  final String text;
  const IosStyleToast({Key? key, required this.text, required this.value, required this.toastType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: tweenOffset.transform(value),
      child: Opacity(
        opacity: tweenOpacity.transform(value),
        child: SafeArea(
          child: DefaultTextStyle(
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(color: ColorName.white),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: Colors.black54,
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        if(toastType == ToastType.success)
                          Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                        if(toastType == ToastType.error)
                          Icon(
                            Icons.error_outline_rounded,
                            color: Colors.white,
                          ),
                        Text(text)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}