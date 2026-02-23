import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/CartViewModel.dart';
import '../routes/AppRoutes.dart'; // Import your routes

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leadingWidth: 70,
        leading: _buildBackButton(context),
        title:
            Text("Cart", style: Theme.of(context).appBarTheme.titleTextStyle),
        centerTitle: true,
      ),
      body: Consumer<CartViewModel>(
        builder: (context, cart, child) {
          if (cart.items.isEmpty) {
            return const Center(
                child: Text("Your cart is empty",
                    style: TextStyle(color: Colors.grey)));
          }

          final groupedItems = <String, List<CartItem>>{};
          for (var item in cart.items) {
            // No more hardcoding!
            final name = item.food.restaurantName ?? "Unknown Restaurant";
            groupedItems.putIfAbsent(name, () => []).add(item);
          }

          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: groupedItems.length,
            itemBuilder: (context, index) {
              final restaurantName = groupedItems.keys.elementAt(index);
              final items = groupedItems[restaurantName]!;
              return _buildRestaurantCard(context, restaurantName, items);
            },
          );
        },
      ),
    );
  }

  Widget _buildRestaurantCard(
      BuildContext context, String name, List<CartItem> items) {
    final firstItem = items.first.food;
    double restaurantTotal = items.fold(0, (sum, item) {
      final price =
          double.tryParse(item.food.price.replaceAll(RegExp(r'[^0-9]'), '')) ??
              0;
      return sum + (price * item.quantity);
    });

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(firstItem.restaurantIcon ?? firstItem.image,
                    width: 70, height: 70, fit: BoxFit.cover),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 4),
                    Text(
                        "₦${restaurantTotal.toStringAsFixed(0)} | ${items.length} Items",
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () =>
                  AppRoutes.navigateToOrderSummary(context, name, items),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF9431),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text("Order Summary",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 8, bottom: 8),
      child: InkWell(
        onTap: () => Navigator.pop(context),
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(12)),
          child: Icon(Icons.arrow_back_ios_new,
              color: Theme.of(context).iconTheme.color, size: 18),
        ),
      ),
    );
  }
}
