import 'package:flutter/material.dart';
import 'package:flutter_web3_games/core/gen/assets.gen.dart';
import 'package:flutter_web3_games/logic/wallet/web3_controller.dart';
import 'package:flutter_web3_games/view/widgets/app_bottom_sheet.dart';
import 'package:flutter_web3_games/view/widgets/base_page.dart';
import 'package:get/get.dart';

import '../widgets/app_button.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<Web3Controller>(
      autoRemove: false,
      builder: (controller){
        return BasePage(body: Center(
            child: FittedBox(
                fit: BoxFit.none,
                child: Column(
                  children: [
                    Text(
                      'Select Wallet to Login',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 50),
                    InkWell(
                      onTap: () {
                        controller.connectWithProvider(context, true);
                      },
                      child: Container(
                        width: 250,
                        padding: EdgeInsets.all(10),
                        child: Center(
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Metamask"),
                              Assets.images.icMetamask
                                  .image(width: 30, height: 30)
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.all(Radius.circular(5)),
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
                        controller.connectWC(context, true);
                      },
                      child: Container(
                        width: 250,
                        padding: EdgeInsets.all(10),
                        child: Center(
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text("WalletConnect"),
                              Assets.images.icWalletconnect
                                  .image(width: 30, height: 30)
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.all(Radius.circular(5)),
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
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
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
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            AppButton(width: 120, height: 50, text: "Learn more"),
                            AppButton(
                              width: 120, height: 50,
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
                )
          ),
        ));
      },
    );
  }
}