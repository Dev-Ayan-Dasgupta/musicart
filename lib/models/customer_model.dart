class Customer {
  String uid;
  String username;
  List cart;
  List cartMap;
  double cartValue;
  List wish;
  List orders;
  // List<List> ordersMap;
  // List orderDate;
  List cards;
  List banks;
  List addresses;
  List currAddress;

  Customer({
    required this.uid,
    required this.username,
    required this.cart,
    required this.cartMap,
    required this.cartValue,
    required this.wish,
    required this.orders,
    // required this.ordersMap,
    // required this.orderDate,
    required this.cards,
    required this.banks,
    required this.addresses,
    required this.currAddress,
  });

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "username": username,
      "cart": cart,
      "cartMap": cartMap,
      "cartValue": cartValue,
      "wish": wish,
      "orders": orders,
      // "ordersMap": ordersMap,
      // "orderDate": orderDate,
      "cards": cards,
      "banks": banks,
      "addresses": addresses,
      "currAddress": currAddress,
    };
  }
}
