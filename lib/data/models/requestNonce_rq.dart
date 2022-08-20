
class RequestNonceRq{

  String walletAddress;
  RequestNonceRq(this.walletAddress);
  Map<String, dynamic> toJson() {
    return {
      'walletAddress': walletAddress,
    };
  }

}