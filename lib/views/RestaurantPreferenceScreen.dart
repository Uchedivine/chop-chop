import 'package:flutter/material.dart';
import '../widgets/PrimaryButton.dart';
import '../widgets/SecondaryButton.dart';

class RestaurantPreferenceScreen extends StatefulWidget {
  const RestaurantPreferenceScreen({super.key});

  @override
  State<RestaurantPreferenceScreen> createState() => _RestaurantPreferenceScreenState();
}

class _RestaurantPreferenceScreenState extends State<RestaurantPreferenceScreen> {
  final Set<int> _selectedIndices = {};

  // Naming conventions based on your asset folder
  final List<Map<String, String>> restaurants = [
    {'name': 'Local Restaurants', 'icon': 'assets/images/local_resturant.png'},
    {'name': 'Fast Foods', 'icon': 'assets/images/fastfood.png'},
    {'name': 'Continental Restaurants', 'icon': 'assets/images/continental_resturant.png'},
    {'name': 'Grills/Suya Spots', 'icon': 'assets/images/suya_spot.png'},
    {'name': 'Cafes & Bakeries', 'icon': 'assets/images/cafe_bakery.png'},
    {'name': 'Street Food Vendors', 'icon': 'assets/images/street_food.png'},
    {'name': 'Vegan', 'icon': 'assets/images/vegan.png'},
    {'name': 'Home-Based', 'icon': 'assets/images/homebased.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress Bar - Step 2 (Orange on Right)
            Row(
              children: [
                Expanded(child: Container(height: 4, decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(2)))),
                const SizedBox(width: 8),
                Expanded(child: Container(height: 4, decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(2)))),
              ],
            ),
            const SizedBox(height: 32),
            const Text(
              "Select Your Preferred Restaurant Types",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            
            // Restaurant Grid
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.85,
                ),
                itemCount: restaurants.length,
                itemBuilder: (context, index) {
                  bool isSelected = _selectedIndices.contains(index);
                  return GestureDetector(
                    onTap: () => setState(() {
                      isSelected ? _selectedIndices.remove(index) : _selectedIndices.add(index);
                    }),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? Colors.orange : Colors.grey.shade300,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(restaurants[index]['icon']!, height: 45),
                          const SizedBox(height: 8),
                          Text(
                            restaurants[index]['name']!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Reuse our modular buttons
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Column(
                children: [
                  PrimaryButton(text: "Continue", onPressed: () { /* Next: Register */ }),
                  const SizedBox(height: 12),
                  SecondaryButton(text: "Skip", onPressed: () { /* Next: Register */ }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}