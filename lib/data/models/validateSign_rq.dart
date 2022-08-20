
class ValidateSignRq {

  String walletAddress;
  String sign;
  ValidateSignRq(this.walletAddress, this.sign);
  Map<String, dynamic> toJson() {
    return {
      'walletAddress': walletAddress,
      'sign': sign,
    };
  }

}