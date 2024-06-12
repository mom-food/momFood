class MealCategory {
  final String id;
  final String name;
  final String image;

  MealCategory ({required this.id, required this.name,required this.image});

  factory MealCategory.fromJson(Map<String, dynamic> json) {
    return MealCategory(
      id: json['_id'],
      name: json['name'],
      image: json['image'],
    );
  }
}