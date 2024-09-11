class Product{
  int id;
  String name;
  String price;
  String category;
  String brand;
  String image_path;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.brand,
    required this.image_path
  });


  // Named constructor for creating an instance from a JSON map
  Product.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        price = json['price'],
        category = json['category'],
        brand = json['brand'],
        image_path = json['image_path'];

  // Method to convert an instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'category': category,
      'brand': brand,
      'image_path': image_path,
    };
  }

}