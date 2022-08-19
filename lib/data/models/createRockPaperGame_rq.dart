

class CreateRockPaperGameRq {

  String walletAddress;
  String txHash;
  String value;

  CreateRockPaperGameRq(this.walletAddress, this.txHash, this.value);
  factory CreateRockPaperGameRq.fromJson(Map<String, dynamic> json) {
    return CreateRockPaperGameRq(
      json['walletAddress'],
      json['txHash'],
      json['value'],
    );
  }
  toJson() {
    return {
      'walletAddress': walletAddress,
      'txHash': txHash,
      'value': value,
    };
  }

}