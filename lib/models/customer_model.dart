class Customer {
  String uid;
  String username;
  List cart;
  List wish;
  List orders;
  List cards;
  List banks;
  List addresses;

  Customer({
    required this.uid,
    required this.username,
    required this.cart,
    required this.wish,
    required this.orders,
    required this.cards,
    required this.banks,
    required this.addresses,
  });

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "username": username,
      "cart": cart,
      "wish": wish,
      "orders": orders,
      "cards": cards,
      "banks": banks,
      "addresses": addresses,
    };
  }
}
