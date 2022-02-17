class ProductTileModel {
  final String id;
  final int price;
  final String name;
  final String image;
  final String brand;
  final bool wishlist;

  ProductTileModel({
    required this.id,
    required this.price,
    required this.name,
    required this.image,
    required this.brand,
    required this.wishlist,
  });

  factory ProductTileModel.fromJson(Map<String, dynamic> json) {
    return ProductTileModel(
      id: json['id'],
      price: json['price'],
      name: json['name'],
      image: json['image'],
      brand: json['brand'],
      wishlist: json['wishlist'],
    );
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'price': price,
      'name': name,
      'image': image,
      'brand': brand,
      'wishlist': wishlist,
    };
  }
}
