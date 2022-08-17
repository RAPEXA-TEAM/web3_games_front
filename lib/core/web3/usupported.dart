import 'package:flutter/cupertino.dart';

Future<void> signNonce(String walletAddress, String nonce, Function(String?) onSigned){
  throw Exception('Not implemented');
}

Future<void> joinGenesisPlayer(String gameId, BigInt value,Function(bool) onPlayerCreatedTheGame){
  throw Exception('Not implemented');
}

Future<void> joinOtherPlayers(String gameId, BigInt value, Function onOtherPlayerJoinedTheGame){
  throw Exception('Not implemented');
}

Future<bool> connectWithProvider(BuildContext buildContext, {bool forceWC = false,Function(List<String>)? onAccountsChanged, Function(int)? onChainChanged}){
  throw Exception('Not implemented');
}

Future<bool> connectWC(BuildContext buildContext, {bool forceWC = false,Function(List<String>)? onAccountsChanged, Function(int)? onChainChanged}){
  throw Exception('Not implemented');
}

Future<void> disconnect(Function onDisconnectedSuccessfully){
  throw Exception('Not implemented');
}

String getWalletAddress(){
  throw Exception('Not implemented');
}

Future<BigInt?> getBalance() async {
  throw Exception('Not implemented');
}