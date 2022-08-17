import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_web3_games/core/pubs/web3dart/crypto.dart';
import 'package:flutter_web3_games/core/pubs/web3dart/src/crypto/sha3.dart';
import 'package:flutter_web3_games/core/web3/constants.dart';
import 'package:flutter_web3_games/view/widgets/app_dialog.dart';
import 'package:flutter_web3_games/view/widgets/app_snackbar.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../pubs/wallectconnect/src/providers/ethereum_walletconnect_provider.dart';
import '../../pubs/wallectconnect/src/session/peer_meta.dart';
import '../../pubs/wallectconnect/src/session/session_status.dart';
import '../../pubs/wallectconnect/src/walletconnect.dart';
import '../../pubs/web3dart/generated/MoneyPool.g.dart';
import '../../pubs/web3dart/src/crypto/hex.dart';
import '../../pubs/web3dart/src/crypto/secp256k1.dart';
import '../../pubs/web3dart/web3dart.dart';

var connector = WalletConnect(
    bridge: 'https://bridge.walletconnect.org',
    clientMeta: const PeerMeta(
        name: 'My App',
        description: 'An app for converting pictures to NFT',
        url: 'https://walletconnect.org',
        icons: [
          'https://files.gitbook.com/v0/b/gitbook-legacy-files/o/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'
        ]));

String? _uri;
SessionStatus? _session;
bool isDialogShowing = false;

String currentAddress = '';

String getWalletAddress() {
  return currentAddress;
}

Web3Client client = Web3Client("https://rpc-mumbai.maticvigil.com/", Client());
Future<BigInt?> getBalance() async {
  var balance = await client.getBalance(EthereumAddress.fromHex(currentAddress));
  return balance.getInEther;
}

Future<bool> connectWithProvider(BuildContext buildContext,
    {bool forceWC = false,
    Function(List<String>)? onAccountsChanged,
    Function(int)? onChainChanged}) async {

  connector.on('connect', (session) {
    if (isDialogShowing && buildContext != null) {
      Navigator.pop(buildContext);
      isDialogShowing = false;
    }
  });

  connector.on('session_update', (payload) => debugPrint(payload.toString()));

  connector.on('disconnect', (session) {
    if (isDialogShowing && buildContext != null) {
      Navigator.pop(buildContext);
      isDialogShowing = false;
    }
  });

  if (!connector.connected) {
    try {
      _session = await connector.createSession(onDisplayUri: (uri) async {
        _uri = uri;
        if ((Theme.of(buildContext).platform == TargetPlatform.iOS ||
                Theme.of(buildContext).platform == TargetPlatform.iOS) &&
            !forceWC) {
          await launchUrlString(uri, mode: LaunchMode.externalApplication);
        } else {
          isDialogShowing = true;
          AppDialogs().showWalletConnectQr(buildContext, uri);
        }
      });
      currentAddress = _session?.accounts[0] ?? '';
      // connector.sessionStorage?.store(connector.session);
      debugPrint(_session?.accounts[0]);
      debugPrint(_session?.chainId.toString());
      if(checkIsSupportedChainId(_session?.chainId)){
        return true;
      }else{
        disconnect((){});
        return false;
      }
    } on Exception catch (exp) {
      debugPrint(exp.toString());
      return false;
    }
  } else {
    return true;
  }
}

@override
Future<void> disconnect(Function onDisconnectedSuccessfully) async {
  if (connector.connected) {
    try {
      await connector.killSession();
      onDisconnectedSuccessfully.call();
    } on Exception catch (exp) {
      debugPrint(exp.toString());
    }
  }
}

Future<void> joinGenesisPlayer(
    String gameId, BigInt value, Function(bool) onPlayerCreatedTheGame) async {
  if (connector.connected) {
    try {
      var provider = EthereumWalletConnectProvider(connector);
      await launchUrlString(_uri!, mode: LaunchMode.externalApplication);
      debugPrint(_uri!);

      final transaction = Transaction(
        maxGas: 1000000,
        to: EthereumAddress.fromHex(contractAddress),
        from: EthereumAddress.fromHex(_session!.accounts[0]),
        value: EtherAmount.fromUnitAndValue(EtherUnit.finney, value),
      );

      final credentials = WalletConnectEthereumCredentials(provider: provider);

      final yourContract = MoneyPool(
          address: EthereumAddress.fromHex(_session!.accounts[0]),
          client: Web3Client('https://rpc-mumbai.maticvigil.com', Client()));

      final result = await yourContract.GenesisPlayer(gameId,
          credentials: credentials, transaction: transaction);
      onPlayerCreatedTheGame.call(true);
    } on Exception catch (exp) {
      debugPrint(exp.toString());
      AppSnackBar.showToast("Error in joining the game 1");
      onPlayerCreatedTheGame.call(false);
    }
  } else {
    AppSnackBar.showToast("Error in joining the game 2");
    onPlayerCreatedTheGame.call(false);
  }
}

Future<void> joinOtherPlayers(
    String gameId, BigInt value, Function onOtherPlayerJoinedTheGame) async {
  if (connector.connected) {
    try {
      var provider = EthereumWalletConnectProvider(connector);
      await launchUrlString(_uri!, mode: LaunchMode.externalApplication);
      debugPrint(_uri!);

      final transaction = Transaction(
        to: EthereumAddress.fromHex(contractAddress),
        from: EthereumAddress.fromHex(_session!.accounts[0]),
        value: EtherAmount.fromUnitAndValue(EtherUnit.finney, value),
      );

      final credentials = WalletConnectEthereumCredentials(provider: provider);
      final yourContract = MoneyPool(
          address: EthereumAddress.fromHex(_session!.accounts[0]),
          client: Web3Client('https://rpc-mumbai.maticvigil.com', Client()));

      final result = await yourContract.OtherPlayer(gameId,
          credentials: credentials, transaction: transaction);
      onOtherPlayerJoinedTheGame.call(true);
    } on Exception catch (exp) {
      debugPrint(exp.toString());
      onOtherPlayerJoinedTheGame.call(false);
    }
  } else {
    onOtherPlayerJoinedTheGame.call(false);
  }
}

Future<void> signNonce(
    String walletAddress,
    String nonce,
    Function onSigned) async {
  if (connector.connected) {
    try {
      var provider = EthereumWalletConnectProvider(connector);
      await launchUrlString(_uri!, mode: LaunchMode.externalApplication);
      debugPrint(_uri!);

      var k = SHA3(256, KECCAK_PADDING, 256);
      k.update(utf8.encode(nonce));
      var hash = k.digest();

      String sign = await provider.personalSign(message: nonce, address: walletAddress, password: '');
      debugPrint(sign);
      onSigned.call(sign);
    } on Exception catch (exp) {
      debugPrint(exp.toString());
      onSigned.call(null);
    }
  } else {
    onSigned.call(null);
  }
}

class WalletConnectEthereumCredentials extends CustomTransactionSender {
  WalletConnectEthereumCredentials({required this.provider});

  final EthereumWalletConnectProvider provider;

  @override
  Future<EthereumAddress> extractAddress() {
    // TODO: implement extractAddress
    throw UnimplementedError();
  }

  @override
  Future<String> sendTransaction(Transaction transaction) async {
    final hash = await provider.sendTransaction(
      from: transaction.from!.hex,
      to: transaction.to?.hex,
      data: transaction.data,
      gas: transaction.maxGas,
      gasPrice: transaction.gasPrice?.getInWei,
      value: transaction.value?.getInWei,
      nonce: transaction.nonce,
    );

    return hash;
  }

  @override
  Future<MsgSignature> signToSignature(Uint8List payload,
      {int? chainId, bool isEIP1559 = false}) {
    // TODO: implement signToSignature
    throw UnimplementedError();
  }
}
