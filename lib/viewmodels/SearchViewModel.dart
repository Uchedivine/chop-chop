import 'package:flutter/material.dart';

class SearchViewModel extends ChangeNotifier {
  // --- Search Screen Data ---
  final List<String> _recentSearches = [
    "Local Restaurants",
    "Chicken Republic",
    "Sharwama",
    "Road side foods in Ajah",
    "Suya places"
  ];

  final List<String> _trendingSearches = [
    "Burger King",
    "Tobi's Suya Spot",
    "Chicken Republic",
    "KFC",
    "Carol G's Burgers and Sharwama Hub",
    "Tantalizers",
    "Okc",
    "Domino's Pizza",
    "Best Road Side Foods",
    "Local Restaurants"
  ];

  // Reuse your category data structure here or fetch from a service
  final List<Map<String, String>> _categories = [
    {'name': 'Local Dishes', 'icon': 'assets/images/local_dishes.png'},
    {'name': 'Continental', 'icon': 'assets/images/continental_meals.png'},
    {'name': 'Grills', 'icon': 'assets/images/grills_bbq.png'},
    {'name': 'Quick Bites', 'icon': 'assets/images/quick_bites.png'},
    {'name': 'Drinks', 'icon': 'assets/images/drinks_refreshments.png'},
  ];

  // --- Filter Screen Data ---
  final List<String> restaurantTypes = [
    "Local Restaurants",
    "Fast Foods",
    "Continental Restaurants",
    "Grills & Suya spots",
    "Cafes & Bakeries",
    "Street Food Vendors",
    "Home based",
    "Vegan"
  ];

  final List<String> mealTypes = [
    "Local Dishes",
    "Continental Meals",
    "Grills & Barbecue",
    "Quick Bites",
    "Drinks & Refreshments",
    "Sweet Treats",
    "Fruits"
  ];

  // --- State Variables ---
  List<String> get recentSearches => _recentSearches;
  List<String> get trendingSearches => _trendingSearches;
  List<Map<String, String>> get categories => _categories;

  // Filter State
  final Set<String> _selectedRestaurantTypes = {};
  final Set<String> _selectedMealTypes = {};
  double _distanceValue = 50.0; // Slider value
  double _budgetStart = 500.0;
  double _budgetEnd = 25000.0;

  Set<String> get selectedRestaurantTypes => _selectedRestaurantTypes;
  Set<String> get selectedMealTypes => _selectedMealTypes;
  double get distanceValue => _distanceValue;
  RangeValues get budgetRange => RangeValues(_budgetStart, _budgetEnd);

  // --- Actions ---

  void removeRecentSearch(String item) {
    _recentSearches.remove(item);
    notifyListeners();
  }

  void clearAllRecentSearches() {
    _recentSearches.clear();
    notifyListeners();
  }

  void toggleRestaurantType(String type) {
    if (_selectedRestaurantTypes.contains(type)) {
      _selectedRestaurantTypes.remove(type);
    } else {
      _selectedRestaurantTypes.add(type);
    }
    notifyListeners();
  }

  void toggleMealType(String type) {
    if (_selectedMealTypes.contains(type)) {
      _selectedMealTypes.remove(type);
    } else {
      _selectedMealTypes.add(type);
    }
    notifyListeners();
  }

  void updateDistance(double value) {
    _distanceValue = value;
    notifyListeners();
  }

  void updateBudget(RangeValues values) {
    _budgetStart = values.start;
    _budgetEnd = values.end;
    notifyListeners();
  }

  void resetFilters() {
    _selectedRestaurantTypes.clear();
    _selectedMealTypes.clear();
    _distanceValue = 50.0;
    _budgetStart = 500.0;
    _budgetEnd = 25000.0;
    notifyListeners();
  }
}
