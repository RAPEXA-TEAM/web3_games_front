
class JoinRockPaperGameRq {

  String walletAddress;
  String txHash;
  String gameId;
  String value;

  JoinRockPaperGameRq(this.walletAddress, this.txHash, this.gameId, this.value);

  factory JoinRockPaperGameRq.fromJson(Map<String, dynamic> json) {
    return JoinRockPaperGameRq(
      json['walletAddress'],
      json['txHash'],
      json['gameId'],
      json['value'],
    );
  }
  toJson() {
    return {
      'walletAddress': walletAddress,
      'txHash': txHash,
      'gameId': gameId,
      'value': value,
    };
  }

}