class CartItem {
  final String id;
  final String productId;
  final Map<String, dynamic> productData;
  final int quantity;
  final String userId;

  CartItem({
    required this.id,
    required this.productId,
    required this.productData,
    required this.quantity,
    required this.userId,
  });

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'] ?? '',
      productId: map['productId'] ?? '',
      productData: Map<String, dynamic>.from(map['productData'] ?? {}),
      quantity: map['quantity'] ?? '',
      userId: map['userId'] ?? '',
    );
  }
}
