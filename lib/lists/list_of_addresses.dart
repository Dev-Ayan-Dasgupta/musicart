import '../models/address_object.dart';

List<AddressObject> myAddresses = [];

AddressObject? currentAddress;

void setOtherAddressesToFalse(AddressObject addObj) {
  for (int i = 0; i < myAddresses.length; i++) {
    if (myAddresses[i] != addObj) {
      myAddresses[i].isCurrentAddress = false;
    } else {
      myAddresses[i].isCurrentAddress = true;
      currentAddress = myAddresses[i];
    }
  }
}