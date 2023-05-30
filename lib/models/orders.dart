class OrderData {
  final String orderId;
  final String items;
  final double totalPrice;
  final DateTime orderDate;

  OrderData({
    required this.orderId,
    required this.items,
    required this.totalPrice,
    required this.orderDate,
  });
}
