
class RequestNonceRq{

  String walletAddress;
  RequestNonceRq(this.walletAddress);
  toJson() {
    return {
      'walletAddress': walletAddress,
    };
  }

}