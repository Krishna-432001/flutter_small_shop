class Order {
  int id;
  String name;
  double price;  // Ensure this is a double
  String category;
  String brand;
  String image_Path;
  int qty;  // Add qty property

  Order({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.brand,
    required this.image_Path,
    required this.qty,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(),  // Convert to double
      category: json['category'],
      brand: json['brand'],
      image_Path: json['image_path'],
      qty: json['qty'],  // Map qty from JSON
    );
  }
}
