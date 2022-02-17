class CategoryTileModel {
  final int id;
  final String name;
  final String image;

  CategoryTileModel({
    required this.id,
    required this.name,
    required this.image,
  });

  factory CategoryTileModel.fromJson(Map<String, dynamic> json) {
    return CategoryTileModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }
}
