import 'package:flutter_web3_games/core/gen/assets.gen.dart';
import 'package:flutter_web3_games/core/gen/icons.dart';
import 'package:flutter_web3_games/core/global_ex.dart';
import 'package:flutter_web3_games/view/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web3_games/view/widgets/popup_menu_button.dart';
import 'package:get/get.dart';

import '../../logic/wallet/web3_controller.dart';

class AppBottomSheets {
  static Widget styledBottomSheetWithCloseButton(
      BuildContext context, Widget body) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 20),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
                color: Theme.of(context).cardColor),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(40),
                child: body,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: EdgeInsets.all(10),
              child: Icon(Icons.close),
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  static showBottomSheetSelectWallet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      constraints: BoxConstraints(
        maxWidth: context.isHorizontalScreen()
            ? double.infinity
            : MediaQuery.of(context).size.width / 2,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (context) => GetBuilder<Web3Controller>(
        autoRemove: false,
        builder: (controller) {
          return !controller.isConnected
              ? styledBottomSheetWithCloseButton(
                  context,
                  Column(
                    children: [
                      SizedBox(height: 20),
                      Text(
                        'Select Wallet',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          controller.connectWithProvider(context, false);
                        },
                        child: Container(
                          width: 250,
                          padding: EdgeInsets.all(10),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Metamask"),
                                Assets.images.icMetamask
                                    .image(width: 30, height: 30)
                              ],
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            border: Border.all(
                              style: BorderStyle.solid,
                              color: Colors.green,
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          controller.connectWC(context, false);
                        },
                        child: Container(
                          width: 250,
                          padding: EdgeInsets.all(10),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("WalletConnect"),
                                Assets.images.icWalletconnect
                                    .image(width: 30, height: 30)
                              ],
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            border: Border.all(
                              style: BorderStyle.solid,
                              color: Colors.green,
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: 250,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: Divider()),
                            SizedBox(width: 10),
                            Text("What is a wallet?"),
                            SizedBox(width: 10),
                            Expanded(child: Divider()),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: SizedBox(
                          width: 250,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppButton(
                                  height: 50, width: 120, text: "Learn more"),
                              AppButton(
                                height: 50,
                                width: 120,
                                text: "Get help",
                                onPressed: () {},
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                          width: 250,
                          child: Text(
                              "By continuing, you agree to the Terms of Service and Privacy Policy")),
                    ],
                  ))
              : styledBottomSheetWithCloseButton(
                  context,
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(30.0)),
                            color: Theme.of(context).cardColor),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(25),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomPopupMenuButton(
                                    actions: [
                                      PopupMenuItemModel(
                                          title: "Refresh funds",
                                          icon: AppIcons.getRefresh(),
                                          onTap: () {}),
                                      PopupMenuItemModel(
                                          title: "Logout",
                                          icon: AppIcons.getLogout(),
                                          onTap: () {
                                            // controller.logout();
                                          }),
                                    ],
                                    icon: Icon(
                                        Icons.account_balance_wallet_rounded),
                                    content: Text("My wallet"),
                                  ),
                                  Text(controller
                                      .getWalletAddressWithDotOverFlow()),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: SizedBox(
                                width: double.infinity,
                                child: Card(
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(height: 20),
                                      Container(
                                        height: 90,
                                        child: Center(
                                          child: Column(
                                            children: [
                                              SizedBox(height: 20),
                                              Text("Total Balance"),
                                              SizedBox(height: 10),
                                              Text(controller.walletBalance,
                                                  style:
                                                      TextStyle(fontSize: 18))
                                            ],
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            style: BorderStyle.solid,
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .color!,
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10)),
                                        ),
                                      ),
                                      Container(
                                        height: 60,
                                        child: Center(child: Text("Add fund")),
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10)),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: InkWell(
                                onTap: () {
                                  controller.genesisPlayerStartDeposit();
                                },
                                child: Text("Test"),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ));
        },
      ),
    );
  }
}
