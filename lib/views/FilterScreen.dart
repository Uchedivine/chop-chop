import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/SearchViewModel.dart';
import '../widgets/PrimaryButton.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchVM = Provider.of<SearchViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(8)),
            child: const Icon(Icons.arrow_back_ios_new, size: 16, color: Colors.black),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Filter", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: searchVM.resetFilters,
            child: const Text("Reset", style: TextStyle(color: Colors.grey, fontSize: 16)),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle("Restaurant Type"),
                    _buildChipGroup(
                      searchVM.restaurantTypes,
                      searchVM.selectedRestaurantTypes,
                      (val) => searchVM.toggleRestaurantType(val),
                    ),
                    const SizedBox(height: 20),
                    _buildSectionTitle("Meal Type"),
                    _buildChipGroup(
                      searchVM.mealTypes,
                      searchVM.selectedMealTypes,
                      (val) => searchVM.toggleMealType(val),
                    ),
                    const SizedBox(height: 20),
                    _buildSectionTitle("Distance"),
                    Slider(
                      value: searchVM.distanceValue,
                      min: 1,
                      max: 50,
                      activeColor: Colors.orange,
                      inactiveColor: Colors.orange.withOpacity(0.2),
                      onChanged: searchVM.updateDistance,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text("1 Km", style: TextStyle(fontSize: 10)),
                          Text("50 Km", style: TextStyle(fontSize: 10)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildSectionTitle("Budget"),
                    RangeSlider(
                      values: searchVM.budgetRange,
                      min: 500,
                      max: 25000,
                      activeColor: Colors.orange,
                      inactiveColor: Colors.orange.withOpacity(0.2),
                      onChanged: searchVM.updateBudget,
                    ),
                     Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("₦${searchVM.budgetRange.start.toInt()}", style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                          Text("₦${searchVM.budgetRange.end.toInt()}", style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: PrimaryButton(
                text: "Apply Filter",
                onPressed: () {
                  // Apply logic here (e.g., fetch new results)
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildChipGroup(List<String> options, Set<String> selected, Function(String) onToggle) {
    return Wrap(
      spacing: 8,
      runSpacing: 10,
      children: options.map((option) {
        final isSelected = selected.contains(option);
        return GestureDetector(
          onTap: () => onToggle(option),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? Colors.orange.withOpacity(0.1) : Colors.white,
              border: Border.all(color: isSelected ? Colors.orange : Colors.grey.shade400),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              option,
              style: TextStyle(
                color: isSelected ? Colors.orange : Colors.grey[700],
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}