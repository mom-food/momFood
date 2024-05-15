class Meal {
  final String id; // You might need an ID property if it's part of your schema
  final String name;
  final String description;
  final double price;
  final String image;
  final String categoryId; // Reference to the Category (category ID)

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
      id: json['_id'], // Adjust this based on your actual ID field
      name: json['name'],
      description: json['description'],
      price: double.tryParse(json['price']) ?? 0,
      image: json['image'],
      categoryId: json['category'], // Assuming the category ID is stored here
    );
  }
}
