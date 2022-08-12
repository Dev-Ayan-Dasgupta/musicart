import '../models/address_object.dart';

List<AddressObject> myAddresses = [];

void setOtherAddressesToFalse(AddressObject addObj) {
  for (int i = 0; i < myAddresses.length; i++) {
    if (myAddresses[i] != addObj) {
      myAddresses[i].isCurrentAddress = false;
    }
  }
}
