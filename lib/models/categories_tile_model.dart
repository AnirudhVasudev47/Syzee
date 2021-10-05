class CategoryTileModel {
  final int count;
  final String name;
  final String image;

  CategoryTileModel({
    required this.count,
    required this.name,
    required this.image,
  });

  CategoryTileModel.fromJson(Map<String, Object?> json)
      : this(
          count: json['count']! as int,
          name: json['name']! as String,
          image: json['image']! as String,
        );

  Map<String, Object?> toJson() {
    return {
      'count': count,
      'name': name,
      'image': image,
    };
  }
}
