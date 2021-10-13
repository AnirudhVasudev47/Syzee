class ProductTileModel {
  final int price;
  final String name;
  final String image;
  final String brand;
  final bool wishlist;

  ProductTileModel({
    required this.price,
    required this.name,
    required this.image,
    required this.brand,
    required this.wishlist,
  });

  ProductTileModel.fromJson(Map<String, Object?> json)
      : this(
    price: json['price']! as int,
    name: json['name']! as String,
    image: json['image']! as String,
    brand: json['brand']! as String,
    wishlist: json['wishlist']! as bool,
  );

  Map<String, Object?> toJson() {
    return {
      'count': price,
      'name': name,
      'image': image,
      'brand': brand,
      'wishlist': wishlist,
    };
  }
}
