class BankObject {
  String bankName;
  String bankUrl;
  String bankImgUrl;

  BankObject({
    required this.bankName,
    required this.bankUrl,
    required this.bankImgUrl,
  });

  Map<String, dynamic> toJsonBank() {
    return {
      "bankName": bankName,
      "bankUrl": bankUrl,
      "bankImgUrl": bankImgUrl,
    };
  }
}
