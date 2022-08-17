
import 'package:flutter_web3_games/core/pubs/wallectconnect/src/session/wallet_connect_session.dart';

abstract class SessionStorage {
  Future store(WalletConnectSession session);

  Future<WalletConnectSession?> getSession();

  Future removeSession();
}
