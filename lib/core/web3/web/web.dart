
import 'package:flutter/cupertino.dart';
import 'package:flutter_web3_games/core/web3/constants.dart';
import 'package:flutter_web3_games/view/widgets/app_snackbar.dart';

import '../../pubs/flutterWeb3/src/ethereum/ethereum.dart';
import '../../pubs/flutterWeb3/src/ethers/ethers.dart';
import '../../pubs/flutterWeb3/src/wallet_connect/wallet_connect.dart';

bool get isInOperatingChain => currentChain == OPERATING_CHAIN;

bool get isConnected =>
    currentAddress.isNotEmpty && currentChain == OPERATING_CHAIN;

String currentAddress = '';

int currentChain = -1;

const OPERATING_CHAIN = 80001;

final wc = WalletConnectProvider.fromRpc(
  {OPERATING_CHAIN: 'https://rpc-mumbai.maticvigil.com/'},
  chainId: OPERATING_CHAIN,
  network: 'Mumbai Testnet',
);
Web3Provider? web3wc;

String getWalletAddress(){
  return currentAddress;
}

Future<BigInt?> getBalance() async {
  return web3wc?.getBalance(currentAddress);
}


clear() {
  currentAddress = '';
  currentChain = -1;
  web3wc = null;
  // update();
}

testSwitchChain() async {
  await ethereum!.walletSwitchChain(80001, () async {
    await ethereum!.walletAddChain(
      chainId: 80001,
      chainName: 'Polygon Testnet',
      nativeCurrency:
          CurrencyParams(name: 'MATIC', symbol: 'MATIC', decimals: 18),
      rpcUrls: ['https://rpc-mumbai.maticvigil.com/'],
    );
  });
}


Future<bool> connectWC() async {
  debugPrint("connect to wc");
  await wc.connect();
  if (wc.connected) {
    currentAddress = wc.accounts.first;
    currentChain = wc.chainId as int;
    if(!checkIsSupportedChainId(currentChain)){
      clear();
      debugPrint("wc chain id not support");
      return false;
    }else{
      currentAddress = wc.accounts.first;
      web3wc = Web3Provider.fromWalletConnect(wc);
      debugPrint("wc connected");
      return true;
    }
  }else{
    debugPrint("wc connection failed");
    return false;
  }
}

Future<bool> connectWithProvider(BuildContext buildContext,
    {bool forceWC = false,
    Function(List<String>)? onAccountsChanged,
    Function(int)? onChainChanged}) async {

  if(forceWC) {
    debugPrint("force wc on");
    return connectWC();
  }
  if (Ethereum.isSupported) {
    ethereum?.onAccountsChanged((accounts) {
      clear();
      onAccountsChanged?.call(accounts);
    });

    ethereum?.onChainChanged((chain) {
      clear();
      onChainChanged?.call(chain);
    });
    ethereum?.onConnect((connectInfo) {

    });
    final account = await ethereum!.requestAccount();
    if (account.isNotEmpty) {
      currentChain = await ethereum!.getChainId();
      if(!checkIsSupportedChainId(currentChain)){
        clear();
        return false;
      }else{
        currentAddress = account.first;
        web3wc = Web3Provider.fromEthereum(ethereum!);
        return true;
      }
    } else {
      return false;
    }
    // update();
  } else {
    return false;
  }
}

Future<void> disconnect(Function onDisconnectedSuccessfully) async {
    clear();
    onDisconnectedSuccessfully.call();
}

Future<void> joinGenesisPlayer(String gameId, BigInt value,
    Function(bool p1) onPlayerCreatedTheGame) async {
  if (web3wc == null) {
    onPlayerCreatedTheGame.call(false);
    return;
  }

  try {
    final busd = Contract(contractAddress, abi, web3wc!.getSigner());
    final tx = await busd.send(
      "GenesisPlayer",
      ["123"],
      TransactionOverride(value: BigInt.from(100), gasLimit: BigInt.from(1000000)),
    );
    await tx.wait();
    onPlayerCreatedTheGame(true);
  } on Exception catch (e) {
    AppSnackBar.showToast("2"+e.toString());
    debugPrint(e.toString());
    onPlayerCreatedTheGame(false);
    return;
  }
}

Future<void> joinOtherPlayers(
    String gameId, BigInt value, Function onOtherPlayerJoinedTheGame) {
  // TODO: implement joinOtherPlayers
  throw UnimplementedError();
}

Future<void> signNonce(String walletAddress, String nonce, Function(String?) onSigned) async{
  if (web3wc == null) {
    onSigned.call(null);
    return;
  }
  try {

    // var k = SHA3(256, KECCAK_PADDING, 256);
    // k.update(utf8.encode(nonce));
    // var hash = k.digest();

    String? sign = await web3wc?.getSigner().signMessage(nonce);
    debugPrint(sign);
    onSigned(sign);
  } on Exception catch (e) {
    AppSnackBar.showToast("2$e");
    debugPrint(e.toString());
    onSigned(null);
    return;
  }
}
