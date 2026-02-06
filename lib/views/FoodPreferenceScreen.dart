import 'package:flutter/material.dart';
import '../widgets/PrimaryButton.dart';
import '../widgets/SecondaryButton.dart'; // Ensure this is imported

class FoodPreferenceScreen extends StatefulWidget {
  const FoodPreferenceScreen({super.key});

  @override
  State<FoodPreferenceScreen> createState() => _FoodPreferenceScreenState();
}

class _FoodPreferenceScreenState extends State<FoodPreferenceScreen> {
  final Set<int> _selectedIndices = {};

  final List<Map<String, String>> categories = [
    {'name': 'Local Dishes', 'icon': 'assets/images/local_dishes.png'},
    {'name': 'Continental Meals', 'icon': 'assets/images/continental_meals.png'},
    {'name': 'Grills & Barbecue', 'icon': 'assets/images/grills_bbq.png'},
    {'name': 'Quick Bites', 'icon': 'assets/images/quick_bites.png'},
    {'name': 'Drinks & Refreshments', 'icon': 'assets/images/drinks_refreshments.png'},
    {'name': 'Sweet Treats', 'icon': 'assets/images/sweet_treats.png'},
    {'name': 'Fruits', 'icon': 'assets/images/fruits.png'},
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
            // Progress Bar
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            const Text(
              "Select Your Food Preferences",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),

            // Category Grid
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.85,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  bool isSelected = _selectedIndices.contains(index);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        isSelected
                            ? _selectedIndices.remove(index)
                            : _selectedIndices.add(index);
                      });
                    },
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
                          Image.asset(categories[index]['icon']!, height: 45),
                          const SizedBox(height: 8),
                          Text(
                            categories[index]['name']!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Action Buttons using reusable widgets
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Column(
                children: [
                  PrimaryButton(
                    text: "Continue",
                    onPressed: () {
                      // Logic for next screen
                    },
                  ),
                  const SizedBox(height: 12),
                  SecondaryButton(
                    text: "Skip",
                    onPressed: () {
                      // Skip logic
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}