import 'package:animated_background/animated_background.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_web3_games/core/consts.dart';
import 'package:flutter_web3_games/core/gen/icons.dart';
import 'package:flutter_web3_games/core/router.dart';
import 'package:flutter_web3_games/logic/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web3_games/view/widgets/app_bottom_sheet.dart';
import 'package:get/get.dart';
import 'package:qlevar_router/qlevar_router.dart';
import '../../core/gen/lng_keys/codegen_loader.g.dart';
import '../../core/pubs/advanceDrawerMenu/src/controller.dart';
import '../../core/pubs/advanceDrawerMenu/src/value.dart';
import '../../core/pubs/advanceDrawerMenu/src/widget.dart';
import '../games/game_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomePageStater();
}

class HomePageStater extends State<HomePage> {
  final _advancedDrawerController = AdvancedDrawerController();

  @override
  void initState() {
    Get.find<AppController>().netOk();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backgroundBehaviour: SpaceBehaviour(),
      backdropColor: Colors.blueGrey,
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: isLanguageFa() ? true : false,
      // openScale: 1.0,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      drawer: SafeArea(
        child: ListTileTheme(
          textColor: Colors.white,
          iconColor: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              // Container(
              //   width: 128.0,
              //   height: 128.0,
              //   margin: const EdgeInsets.only(
              //     top: 24.0,
              //     bottom: 64.0,
              //   ),
              //   clipBehavior: Clip.antiAlias,
              //   decoration: const BoxDecoration(
              //     color: Colors.black26,
              //     shape: BoxShape.circle,
              //   ),
              //   child: InkWell(
              //     onTap: (){
              //       _advancedDrawerController.hideDrawer();
              //       Navigator.pushNamed(context, USER_PROFILE_ROUTE);
              //     },
              //     child: Assets.images.clashroyallogo.image(),
              //   ),
              // ),
              // if (SharedStore.getUser() == false) ...[
              //   //todo for managing
              // ],
              ListTile(
                onTap: () {
                  _advancedDrawerController.hideDrawer();
                  AppBottomSheets.showBottomSheetSelectWallet(context);
                },
                leading: Icon(AppIcons.getWallet()),
                title: Text("Wallet"),
              ),
              ListTile(
                onTap: () {
                  _advancedDrawerController.hideDrawer();
                  // Navigator.pushNamed(context, SETTINGS_ROUTE);
                },
                leading: Icon(AppIcons.getAboutUs()),
                title: Text(LocaleKeys.aboutUs).tr(),
              ),
              ListTile(
                onTap: () {
                  _advancedDrawerController.hideDrawer();
                  QR.to(SETTINGS_ROUTE);
                },
                leading: Icon(AppIcons.getSetting()),
                title: Text(LocaleKeys.settings).tr(),
              ),
              const Spacer(),
              DefaultTextStyle(
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white54,
                ),
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 16.0,
                  ),
                  child: Text('Terms of Service | Privacy Policy'),
                ),
              ),
            ],
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(LocaleKeys.games).tr(),
          leading: IconButton(
            onPressed: _handleMenuButtonPressed,
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: _advancedDrawerController,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: Duration(milliseconds: 250),
                  child: Icon(
                    value.visible ? Icons.clear : Icons.menu,
                    key: ValueKey<bool>(value.visible),
                  ),
                );
              },
            ),
          ),
        ),
        body: const GamePage(fromHome: true),
      ),
    );
  }

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }
}
