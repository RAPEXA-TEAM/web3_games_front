// Generated code, do not modify. Run `build_runner build` to re-generate!
// @dart=2.12
// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_web3_games/core/pubs/web3dart/web3dart.dart' as _i1;

final _contractAbi = _i1.ContractAbi.fromJson(
    '[{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"sender","type":"address"},{"indexed":false,"internalType":"string","name":"message","type":"string"}],"name":"Log","type":"event"},{"inputs":[{"internalType":"string","name":"","type":"string"},{"internalType":"uint256","name":"","type":"uint256"}],"name":"pool","outputs":[{"internalType":"address","name":"sender","type":"address"},{"internalType":"uint256","name":"amount","type":"uint256"},{"internalType":"uint256","name":"timestamp","type":"uint256"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[{"internalType":"string","name":"gameId","type":"string"}],"name":"GenesisPlayer","outputs":[],"stateMutability":"payable","type":"function","payable":true},{"inputs":[{"internalType":"string","name":"gameId","type":"string"}],"name":"OtherPlayer","outputs":[],"stateMutability":"payable","type":"function","payable":true},{"inputs":[{"internalType":"address payable","name":"winnerAddress","type":"address"},{"internalType":"string","name":"gameId","type":"string"}],"name":"withdrawToWin","outputs":[],"stateMutability":"payable","type":"function","payable":true}]',
    'MoneyPool');

class MoneyPool extends _i1.GeneratedContract {
  MoneyPool(
      {required _i1.EthereumAddress address,
        required _i1.Web3Client client,
        int? chainId})
      : super(_i1.DeployedContract(_contractAbi, address), client, chainId);

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<Pool> pool(String $param0, BigInt $param1,
      {_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[0];
    assert(checkSignature(function, '21378c44'));
    final params = [$param0, $param1];
    final response = await read(function, params, atBlock);
    return Pool(response);
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> GenesisPlayer(String gameId,
      {required _i1.Credentials credentials,
        _i1.Transaction? transaction}) async {
    final function = self.abi.functions[1];
    assert(checkSignature(function, '3e6ba9e0'));
    final params = [gameId];
    return write(credentials, transaction, function, params);
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> OtherPlayer(String gameId,
      {required _i1.Credentials credentials,
        _i1.Transaction? transaction}) async {
    final function = self.abi.functions[2];
    assert(checkSignature(function, '263d4ef7'));
    final params = [gameId];
    return write(credentials, transaction, function, params);
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> withdrawToWin(_i1.EthereumAddress winnerAddress, String gameId,
      {required _i1.Credentials credentials,
        _i1.Transaction? transaction}) async {
    final function = self.abi.functions[3];
    assert(checkSignature(function, 'af9dfdaa'));
    final params = [winnerAddress, gameId];
    return write(credentials, transaction, function, params);
  }

  /// Returns a live stream of all Log events emitted by this contract.
  Stream<Log> logEvents({_i1.BlockNum? fromBlock, _i1.BlockNum? toBlock}) {
    final event = self.event('Log');
    final filter = _i1.FilterOptions.events(
        contract: self, event: event, fromBlock: fromBlock, toBlock: toBlock);
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(result.topics!, result.data!);
      return Log(decoded);
    });
  }
}

class Pool {
  Pool(List<dynamic> response)
      : sender = (response[0] as _i1.EthereumAddress),
        amount = (response[1] as BigInt),
        timestamp = (response[2] as BigInt);

  final _i1.EthereumAddress sender;

  final BigInt amount;

  final BigInt timestamp;
}

class Log {
  Log(List<dynamic> response)
      : sender = (response[0] as _i1.EthereumAddress),
        message = (response[1] as String);

  final _i1.EthereumAddress sender;

  final String message;
}
