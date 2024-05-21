class MenuItem {
  final String id;
  final String name;
  final String imageUrl;
  final double price;

  MenuItem({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      price: json['price'].toDouble(),
    );
  }
}