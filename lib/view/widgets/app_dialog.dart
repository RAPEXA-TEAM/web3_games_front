import 'package:flutter_web3_games/core/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web3_games/core/gen/assets.gen.dart';
import 'package:qr_flutter/qr_flutter.dart';

class AppDialogs {
  Function? onOfflinePressed;
  Function? onOnlinePressed;

  showOnlineOrOfflinePlayDialog(
    BuildContext context, {
    Function? onOfflinePressed,
    Function? onOnlinePressed,
  }) {
    if (isAppStyleMaterial()) {
      showDialog(
        context: context,
        builder: (context) => Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text("Select Game Type"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => onOfflinePressed?.call(),
                        child: Column(
                          children: [
                            Assets.images.icBot.image(height: 50, width: 50),
                            const SizedBox(height: 10),
                            const Text("Offline")
                          ],
                        ),
                      ),
                      const SizedBox(width: 80),
                      InkWell(
                        onTap: () => onOnlinePressed?.call(),
                        child: Column(
                          children: [
                            Assets.images.icMultiPlayer
                                .image(height: 50, width: 50),
                            const SizedBox(height: 10),
                            const Text("Online")
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
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
                  fit: BoxFit.scaleDown,
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text("Select Game Type"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () => onOfflinePressed?.call(),
                              child: Column(
                                children: [
                                  Assets.images.icBot
                                      .image(height: 50, width: 50),
                                  const SizedBox(height: 10),
                                  const Text("Offline")
                                ],
                              ),
                            ),
                            const SizedBox(width: 80),
                            InkWell(
                              onTap: () => onOnlinePressed?.call(),
                              child: Column(
                                children: [
                                  Assets.images.icMultiPlayer
                                      .image(height: 50, width: 50),
                                  const SizedBox(height: 10),
                                  const Text("Online")
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          });
    }
  }

  showWalletConnectQr(BuildContext context, String qr) {
    if (isAppStyleMaterial()) {
      showDialog(
        context: context,
        builder: (context) => Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
          child: FittedBox(
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
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        "Scan Qr with walletconnect-compatible wallets",
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ),
                    QrImage(data: qr, size: 380)
                  ],
                ),
              ),
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
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            "Scan Qr with walletconnect-compatible wallets",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        QrImage(data: qr, size: 380)
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        },
      );
    }
  }

  Function? onYesPressed;
  Function? onNoPressed;
  String? title;
  String? message;

  shoAppDialog(
    BuildContext context, {
    String? title,
    String? message,
    Function? onYesPressed,
    Function? onNoPressed,
  }) {
    if (isAppStyleMaterial()) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(title ?? ""),
                content: Text(message ?? ""),
                actions: <Widget>[
                  TextButton(
                    child: const Text("Yes"),
                    onPressed: () {
                      onYesPressed?.call();
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: const Text("No"),
                    onPressed: () {
                      onNoPressed?.call();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ));
    } else {
      showCupertinoDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text(title ?? ""),
              content: Text(message ?? ""),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: const Text("Yes", style: TextStyle(color: Colors.blue)),
                  onPressed: () {
                    onYesPressed?.call();
                    Navigator.of(context).pop();
                  },
                ),
                CupertinoDialogAction(
                  child: const Text("No", style: TextStyle(color: Colors.blue)),
                  onPressed: () {
                    onNoPressed?.call();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    }
  }
}
