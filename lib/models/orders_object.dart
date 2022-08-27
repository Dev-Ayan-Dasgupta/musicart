class OrderObject {
  List items;
  List units;
  DateTime dateTime;
  double orderValue;
  Map addressOfOrder;

  OrderObject({
    required this.items,
    required this.units,
    required this.dateTime,
    required this.orderValue,
    required this.addressOfOrder,
  });

  Map<String, dynamic> toJsonOrder() {
    return {
      "items": items,
      "units": units,
      "dateTime": dateTime,
      "orderValue": orderValue,
      "addressOfOrder": addressOfOrder,
    };
  }
}
