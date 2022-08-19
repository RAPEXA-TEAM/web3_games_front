import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_web3_games/core/consts.dart';
import 'package:flutter_web3_games/data/datasources/local/sharedStore.dart';
import 'package:flutter_web3_games/data/models/requestNonce_rp.dart';
import 'package:flutter_web3_games/data/repositories/auth_repository.dart';
import 'package:flutter_web3_games/view/widgets/app_dialog.dart';
import 'package:flutter_web3_games/view/widgets/app_snackbar.dart';
import 'package:get/get.dart';
import '../../core/web3/provider.dart' as provider;
import '../../core/web3/native/walletconnect.dart' as native;
import '../../data/models/requestNonce_rq.dart';
import '../../data/models/validateSign_rq.dart';

class Web3Controller extends GetxController {

  AuthRepository _authRepository;

  Web3Controller(this._authRepository);

  bool isConnected = false;
  bool gameStarted = false;

  String get walletAddress => provider.getWalletAddress();

  String getWalletAddressWithDotOverFlow() {
    try {
      return "${walletAddress.substring(0, 5)}...${walletAddress.substring(
          walletAddress.length - 5,
          walletAddress.length)}";
    } on RangeError catch (e) {
      return "status: not connect";
    }
  }


  String walletBalance = '';

  void getBalance(Function(String) onReceivedBalance) {
    provider
        .getBalance()
        .then((value) => {onReceivedBalance.call(value.toString())});
  }

  Future<void> connectWC(BuildContext buildContext, bool forLogin) async {
    isConnected =
    await provider.connectWithProvider(buildContext, forceWC: true);
    if (isConnected) {
      getBalance((p0) {
        walletBalance = p0;
        update();
      });
      if (forLogin) {
        await requestNonce(onSuccess: (nonce) {
          validateSign(nonce);
        });
      }
      AppSnackBar.showSuccess('Connection Successfully');
    } else {
      AppSnackBar.showError('Connection failed');
      update();
    }
  }

  Future<void> connectWithProvider(BuildContext buildContext,
      bool forLogin) async {
    isConnected = await provider.connectWithProvider(buildContext);
    if (isConnected) {
      getBalance((p0) {
        walletBalance = p0;
        update();
      });
      if (forLogin) {
        await requestNonce(onSuccess: (nonce) {
          validateSign(nonce);
        });
      }
      AppSnackBar.showSuccess('Connection Successfully');
    } else {
      AppSnackBar.showError('Connection failed');
      update();
    }
  }

  String depositValue = '100000';
  onDepositTextFieldChanged(String value){
    depositValue = depositValue;
  }
  Future<void> genesisPlayerStartDeposit() async {
    await provider.joinGenesisPlayer(
      "1",
      BigInt.parse(depositValue),
          (success) {
        gameStarted = success;
        if (success) {
          AppSnackBar.showToast('Game started successfully');
        } else {
          // AppSnackBar.showToast('Game start failed');
        }
        update();
      },
    );
  }

  Future<void> otherPlayerStartDeposit(String gameId, String gameDepositValue) async {
    await provider.joinOtherPlayers(
      gameId,
      BigInt.parse(gameDepositValue),
          (success) {
        gameStarted = success;
        if (success) {
          AppSnackBar.showToast('Join to game successfully');
        } else {
          AppSnackBar.showToast('Join to game failed');
        }
        update();
      },
    );
  }

  ReqStatus requestNonceReqStatus = ReqStatus.initial;
  requestNonce({required Function(String) onSuccess})  {
    if (requestNonceReqStatus != ReqStatus.loading) {
      _authRepository.requestNonce(RequestNonceRq(walletAddress), start: () {
        requestNonceReqStatus = ReqStatus.loading;
        AppSnackBar.showLoading();
        update();
      }, error: (error) {
        requestNonceReqStatus = ReqStatus.error;
        AppSnackBar.showError(error.error);
        update();
      }, success: (response) {
        requestNonceReqStatus = ReqStatus.success;
        if (response.data?.nonce != null) {
          provider.signNonce(walletAddress, response.data!.nonce!, (sign) {
            if (sign != null) {
              onSuccess.call(sign);
            } else {
              onSuccess.call('Sign failed');
              AppSnackBar.showError('Sign failed');
            }
          });
        }
        update();
      });
    }
  }

  ReqStatus validateSignReqStatus = ReqStatus.initial;

  validateSign(String sign) {
    if(validateSignReqStatus != ReqStatus.loading){
      _authRepository.validateSign(
          ValidateSignRq(walletAddress, sign), start: () {
        validateSignReqStatus = ReqStatus.loading;
        AppSnackBar.showLoading();
        update();
      }, error: (error) {
        validateSignReqStatus = ReqStatus.error;
        AppSnackBar.showError(error.error);
        update();
      }, success: (response) {
        validateSignReqStatus = ReqStatus.success;
        if (response.data?.success == true) {
          SharedStore.setRegisteredWalletAddress(walletAddress);
          AppSnackBar.showSuccess("Sign validated successfully");
        } else {
          AppSnackBar.showError("Signature validation failed");
        }
        update();
      });
    }
  }

  void logout() {
    isConnected = false;
    provider.disconnect(() {
      AppSnackBar.showSuccess("Wallet Logout Successfully");
    });
    update();
  }
}
