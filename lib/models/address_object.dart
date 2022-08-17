class AddressObject {
  String personName;
  //String? type;
  String addressLine1;
  String addressLine2;
  String? landmark;
  String city;
  String state;
  String pinCode;
  bool isCurrentAddress;
  double latitude;
  double longitude;
  AddressObject({
    required this.personName,
    //this.type,
    required this.addressLine1,
    required this.addressLine2,
    this.landmark,
    required this.city,
    required this.state,
    required this.pinCode,
    required this.isCurrentAddress,
    required this.latitude,
    required this.longitude,
  });
}
