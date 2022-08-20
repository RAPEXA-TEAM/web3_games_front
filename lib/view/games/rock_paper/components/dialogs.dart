import 'package:flutter_web3_games/core/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web3_games/core/global_ex.dart';
import 'package:flutter_web3_games/logic/games/rock_paper/rock_paper_controller.dart';
import 'package:flutter_web3_games/logic/wallet/web3_controller.dart';
import 'package:flutter_web3_games/view/widgets/app_bottom_sheet.dart';
import 'package:flutter_web3_games/view/widgets/app_snackbar.dart';
import 'package:get/get.dart';
import '../../../widgets/app_button.dart';

class RockPaperDialogs {
  showCreateGameDialog(BuildContext context) {
    if (Get.find<Web3Controller>().walletBalance.isNotEmpty) {
      if (isAppStyleMaterial()) {
        showDialog(
          context: context,
          builder: (context) => Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0)),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(25.0),
                color: Colors.white,
              ),
              child: SizedBox(
                height: 420,
                width: 400,
                child: CreateGameDialogBody(),
              ),
            ),
          ),
        );
      } else {
        showCupertinoDialog(
          barrierDismissible: true,
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              actions: [
                FittedBox(
                  fit: BoxFit.contain,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(25.0),
                      color: Colors.white,
                    ),
                    child: SizedBox(
                      height: 420,
                      width: 400,
                      child: CreateGameDialogBody(),
                    ),
                  ),
                )
              ],
            );
          },
        );
      }
    } else {
      AppSnackBar.showError("You are not connect to a wallet");
      AppBottomSheets.showBottomSheetSelectWallet(context);
    }
  }
}

class CreateGameDialogBody extends StatelessWidget {
  const CreateGameDialogBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RockPaperController>(builder: (controller) {
      return Column(
              children: [
                Text("You first need deposit some coin to create a game"),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                      labelText: "Your balance: ${Get.find<Web3Controller>().walletBalance}",
                      hintText: "Enter game deposit amount"),
                ),
                AppButton(
                  height: 50,
                  width: 100,
                  text: "Deposit",
                  onPressed: () {
                    Get.back();
                  },
                )
              ],
            );
    });
  }
}
