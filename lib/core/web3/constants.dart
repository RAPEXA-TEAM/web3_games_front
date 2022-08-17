import 'package:flutter_web3_games/view/widgets/app_snackbar.dart';

final abi = [
  'function GenesisPlayer(string gameId) public payable',
  'function OtherPlayer(string gameId) public payable',
  'function withdrawToWin(address payable winnerAddress, string gameId) payable external'
];

const contractAddress = '0xE029D63dD0eC859ADCeD490Cee1010Cf80caFF36';

const supportedChainId = [
  80001
];

bool checkIsSupportedChainId(int? chainId) {
  if (chainId == null) {
    AppSnackBar.showError("wrong try again");
    return false;
  }
  bool isSupportedChain = false;
  for (var element in supportedChainId) {
    if (element == chainId) {
      isSupportedChain = true;
      break;
    }
  }
  if(isSupportedChain == false){
    AppSnackBar.showError("network not supported please switch to Polygon");
    return false;
  }
  return isSupportedChain;
}