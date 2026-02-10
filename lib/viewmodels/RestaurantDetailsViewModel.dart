import 'package:flutter/material.dart';
import '../models/MenuItem.dart';

class RestaurantDetailsViewModel extends ChangeNotifier {
  int _selectedCategoryIndex = 0;
  int get selectedCategoryIndex => _selectedCategoryIndex;

  // Restaurant data
  Map<String, dynamic>? _restaurantData;
  Map<String, dynamic>? get restaurantData => _restaurantData;

  final List<String> categories = [
    "Main Dish",
    "Local Dishes",
    "Side Dishes",
    "Drinks",
    "Snacks"
  ];

  // Restaurant-specific logos mapping
  final Map<String, String> restaurantLogos = {
    '330 Eats': 'assets/images/330logo.png',
    'Mega Chicken': 'assets/images/mega_chickenlogo.png',
    'Prisca Sharwama': 'assets/images/prisca_sharwamalogo.png',
    'Godbless Chicken & Chips': 'assets/images/godbless_chicken_chipslogo.png',
    'Chicken Republic': 'assets/images/chicken_replogo.png',
    'Burger King': 'assets/images/burger_kinglogo.png',
  };

  // Restaurant-specific menu items
  final Map<String, List<MenuItem>> restaurantMenus = {
    '330 Eats': [
      MenuItem(
        name: "Jellof Rice and Chicken",
        description:
            "Basimati spicy jellof rice with scented leaves and peppered fried chicken. Options of moi-moi and soft drinks on the side for extra charges.",
        price: "₦4,000",
        image: "assets/images/jollofrice.png",
        category: "Main Dish",
        discount: "-5% Discount",
      ),
      MenuItem(
        name: "Fried Rice and Chicken",
        description:
            "Basimati spicy jellof rice with scented leaves and peppered fried chicken. Options of moi-moi and soft drinks on the side for extra charges.",
        price: "₦4,200",
        image: "assets/images/friedrice.png",
        category: "Main Dish",
      ),
      MenuItem(
        name: "White Rice and Chicken Sauce",
        description:
            "Basimati spicy jellof rice with scented leaves and peppered fried chicken. Options of moi-moi and soft drinks on the side for extra charges.",
        price: "₦5,500",
        image: "assets/images/whiterice.png",
        category: "Main Dish",
      ),
    ],
    'Prisca Sharwama': [
      MenuItem(
        name: "Chicken Shawarma",
        description:
            "Grilled chicken with fresh vegetables, wrapped in soft pita bread with our signature sauce.",
        price: "₦2,500",
        image: "assets/images/chicken_sharwama.jpeg",
        category: "Main Dish",
      ),
      MenuItem(
        name: "Beef Shawarma",
        description:
            "Tender beef strips with lettuce, tomatoes, and special spicy sauce in warm pita.",
        price: "₦3,000",
        image: "assets/images/beef_sharwama.jpeg",
        category: "Main Dish",
        discount: "-10% Discount",
      ),
      MenuItem(
        name: "Mixed Shawarma",
        description:
            "Perfect combination of chicken and beef with extra veggies and double sauce.",
        price: "₦3,500",
        image: "assets/images/mixed_sharwama.jpeg",
        category: "Main Dish",
      ),
      MenuItem(
        name: "Fries",
        description: "Crispy golden french fries, perfectly seasoned.",
        price: "₦800",
        image: "assets/images/fries.jpeg",
        category: "Side Dishes",
      ),
      MenuItem(
        name: "Coca Cola",
        description: "Chilled 50cl Coca Cola",
        price: "₦400",
        image: "assets/images/coke.jpeg",
        category: "Drinks",
      ),
    ],
    'Chicken Republic': [
      MenuItem(
        name: "Refuel Max",
        description:
            "Quarter chicken, jollof rice, coleslaw and a drink. The perfect meal combo.",
        price: "₦4,500",
        image: "assets/images/refuel_max.jpeg",
        category: "Main Dish",
      ),
      MenuItem(
        name: "Chicken and Chips",
        description:
            "Crispy fried chicken served with golden fries and ketchup.",
        price: "₦3,200",
        image: "assets/images/chicken_chips.jpeg",
        category: "Main Dish",
      ),
      MenuItem(
        name: "Citizen Meal",
        description: "Half chicken, jollof rice, plantain and coleslaw.",
        price: "₦5,800",
        image: "assets/images/citizen_meal.jpeg",
        category: "Main Dish",
        discount: "-15% Discount",
      ),
    ],
    'Burger King': [
      MenuItem(
        name: "Whopper",
        description:
            "Our signature flame-grilled beef patty with fresh vegetables and special sauce.",
        price: "₦3,800",
        image: "assets/images/whopper.jpeg",
        category: "Main Dish",
      ),
      MenuItem(
        name: "Chicken Royale",
        description:
            "Crispy chicken fillet with lettuce, mayo and cheese on a toasted bun.",
        price: "₦3,500",
        image: "assets/images/chicken_royale.jpeg",
        category: "Main Dish",
      ),
      MenuItem(
        name: "Double Whopper",
        description:
            "Two flame-grilled beef patties with all the classic toppings.",
        price: "₦5,200",
        image: "assets/images/double_whopper.jpeg",
        category: "Main Dish",
        discount: "-5% Discount",
      ),
    ],
    'Mega Chicken': [
      MenuItem(
        name: "Mega Combo",
        description: "Full chicken, large fries, coleslaw and 1.5L drink.",
        price: "₦8,500",
        image: "assets/images/mega_combo.jpeg",
        category: "Main Dish",
      ),
      MenuItem(
        name: "Spicy Wings",
        description: "6 pieces of spicy chicken wings with special hot sauce.",
        price: "₦2,800",
        image: "assets/images/spicy_wings.jpeg",
        category: "Main Dish",
      ),
    ],
    'Godbless Chicken & Chips': [
      MenuItem(
        name: "Classic Chicken & Chips",
        description: "Quarter chicken with crispy chips and pepper sauce.",
        price: "₦2,500",
        image: "assets/images/classic_chicken_chips.jpeg",
        category: "Main Dish",
      ),
      MenuItem(
        name: "Family Pack",
        description: "Whole chicken, large chips and coleslaw for the family.",
        price: "₦7,000",
        image: "assets/images/family_pack.jpeg",
        category: "Main Dish",
        discount: "-20% Discount",
      ),
    ],
  };

  List<MenuItem> _currentMenuItems = [];

  List<MenuItem> get filteredItems => _currentMenuItems
      .where((item) => item.category == categories[_selectedCategoryIndex])
      .toList();

  // Initialize with restaurant data
  void setRestaurantData(Map<String, dynamic> data) {
    _restaurantData = data;

    // Load restaurant-specific menu
    String restaurantName = data['name'] ?? '330 Eats';
    _currentMenuItems =
        restaurantMenus[restaurantName] ?? restaurantMenus['330 Eats']!;

    notifyListeners();
  }

  // Get restaurant logo based on name
  String getRestaurantLogo() {
    if (_restaurantData == null) return 'assets/images/330logo.png';
    String restaurantName = _restaurantData!['name'] ?? '330 Eats';
    return restaurantLogos[restaurantName] ?? 'assets/images/330logo.png';
  }

  void selectCategory(int index) {
    _selectedCategoryIndex = index;
    notifyListeners();
  }
}
