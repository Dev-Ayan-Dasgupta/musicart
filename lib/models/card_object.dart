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
}
