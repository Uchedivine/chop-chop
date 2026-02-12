class MenuItem {
  final String name;
  final String description;
  final String price;
  final String image;
  final String category;
  final String? discount;
  final String? restaurantName;
  final String? restaurantIcon;
  final String? deliveryTime; // e.g., "30 - 40 mins"
  final String? deliveryFee;  // e.g., "₦900"

  MenuItem({
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.category,
    this.discount,
    this.restaurantName,
    this.restaurantIcon,
    this.deliveryTime,
    this.deliveryFee,
  });
}