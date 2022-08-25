class CardObject {
  String ownerName;
  String cardNum;
  String monthOfExpiry;
  String dayofExpiry;
  String cvv;
  String providerImgUrl;

  CardObject({
    required this.ownerName,
    required this.cardNum,
    required this.monthOfExpiry,
    required this.dayofExpiry,
    required this.cvv,
    required this.providerImgUrl,
  });

  Map<String, dynamic> toJsonCards() {
    return {
      "ownerName": ownerName,
      "cardNum": cardNum,
      "monthOfExpiry": monthOfExpiry,
      "dayofExpiry": dayofExpiry,
      "cvv": cvv,
      "providerImgUrl": providerImgUrl,
    };
  }
}
