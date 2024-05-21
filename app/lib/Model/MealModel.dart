class Meal {
  final String id;
  final String name;
  final String description;
  final double price;
  final String image;
  final String categoryId;

  Meal({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.categoryId,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      image: json['image'],
      categoryId: json['category'],
    );
  }
}
