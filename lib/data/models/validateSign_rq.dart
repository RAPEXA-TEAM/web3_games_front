
class ValidateSignRq {

  String walletAddress;
  String sign;
  ValidateSignRq(this.walletAddress, this.sign);
  toJson() {
    return {
      'walletAddress': walletAddress,
      'sign': sign,
    };
  }

}