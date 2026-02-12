import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/MenuItem.dart';
import '../viewmodels/FoodDetailsViewModel.dart';
import '../viewmodels/CartViewModel.dart';

class FoodDetailsScreen extends StatelessWidget {
  const FoodDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MenuItem item =
        ModalRoute.of(context)!.settings.arguments as MenuItem;

    return ChangeNotifierProvider(
      create: (_) => FoodDetailsViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Consumer<FoodDetailsViewModel>(
          builder: (context, vm, child) {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeader(context, item),
                        _buildFoodInfo(item),
                        _buildAdditionalOptions(vm),
                      ],
                    ),
                  ),
                ),
                _buildBottomAction(context, item, vm),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, MenuItem item) {
    return Stack(
      children: [
        Image.asset(item.image,
            width: double.infinity, height: 350, fit: BoxFit.cover),
        Positioned(
          top: 50,
          left: 20,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const CircleAvatar(
              backgroundColor: Colors.white,
              child:
                  Icon(Icons.arrow_back_ios_new, size: 18, color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFoodInfo(MenuItem item) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(item.name,
              style:
                  const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(item.price,
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
          const SizedBox(height: 15),
          Text(item.description,
              style: const TextStyle(
                  color: Colors.grey, fontSize: 14, height: 1.5)),
        ],
      ),
    );
  }

  Widget _buildAdditionalOptions(FoodDetailsViewModel vm) {
    final List<Map<String, String>> options = [
      {'name': 'Moi - Moi', 'price': '+₦800'},
      {'name': 'Plantain', 'price': '+₦1,200'},
      {'name': '50cl Pet Bottle Drink', 'price': '+₦800'},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Additional Options",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 15),
          ...options.map((opt) => _optionTile(opt, vm)).toList(),
        ],
      ),
    );
  }

  Widget _optionTile(Map<String, String> opt, FoodDetailsViewModel vm) {
    bool isSelected = vm.selectedOptions.contains(opt['name']);
    return GestureDetector(
      onTap: () => vm.toggleOption(opt['name']!),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(opt['name']!,
                    style: const TextStyle(fontWeight: FontWeight.w500)),
                Text(opt['price']!,
                    style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
            Icon(
              isSelected ? Icons.check_circle : Icons.circle_outlined,
              color:
                  isSelected ? const Color(0xFFFF9431) : Colors.grey.shade300,
            ),
          ],
        ),
      ),
    );
  }

  // Add BuildContext context here 👇
Widget _buildBottomAction(BuildContext context, MenuItem item, FoodDetailsViewModel vm) {
  return Container(
    padding: const EdgeInsets.all(25),
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))],
    ),
    child: Column(
      children: [
        _quantitySelector(vm),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Total", style: TextStyle(color: Colors.grey, fontSize: 12)),
                Text(vm.calculateTotal(item.price), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                // Now 'context' is available for Provider and Navigator!
                Provider.of<CartViewModel>(context, listen: false).addToCart(
                  item, 
                  vm.quantity, 
                  vm.selectedOptions.toList()
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Added to cart!"), duration: Duration(seconds: 1))
                );
                
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF9431),
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text("Add to Cart", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ],
    ),
  );
}

  Widget _quantitySelector(FoodDetailsViewModel vm) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(onPressed: vm.decrement, icon: const Icon(Icons.remove)),
          Text("${vm.quantity}",
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          IconButton(onPressed: vm.increment, icon: const Icon(Icons.add)),
        ],
      ),
    );
  }
}
