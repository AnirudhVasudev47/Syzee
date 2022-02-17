class SubCategoryModel {
  final int id;
  final String name;

  SubCategoryModel({
    required this.id,
    required this.name,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
