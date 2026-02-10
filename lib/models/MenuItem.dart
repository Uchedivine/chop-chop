class MenuItem {
  final String name;
  final String description;
  final String price;
  final String image;
  final String category;
  final String? discount;

  MenuItem({
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.category,
    this.discount,
  });
}