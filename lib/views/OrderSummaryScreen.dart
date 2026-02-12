import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/CartViewModel.dart';

class OrderSummaryScreen extends StatelessWidget {
  final String restaurantName;
  final List<CartItem> restaurantItems;

  const OrderSummaryScreen({
    super.key, 
    required this.restaurantName, 
    required this.restaurantItems
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("Order Summary", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18)),
        centerTitle: true,
      ),
      body: Consumer<CartViewModel>(
        builder: (context, cart, child) {
          // Re-filter items in case quantities changed or items were removed
          final currentItems = cart.items.where((item) => item.food.restaurantName == restaurantName).toList();

          if (currentItems.isEmpty) {
            return const Center(child: Text("No items for this restaurant"));
          }

          double subtotal = currentItems.fold(0, (sum, item) {
            final price = double.tryParse(item.food.price.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
            return sum + (price * item.quantity);
          });
          double deliveryFee = 900;

          return Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Restaurant: $restaurantName", style: const TextStyle(fontWeight: FontWeight.w500)),
                        IconButton(
                          onPressed: () {
                            cart.clearRestaurantFromCart(restaurantName);
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.delete_outline, color: Colors.red),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: currentItems.length,
                      itemBuilder: (context, index) {
                        final item = currentItems[index];
                        return _buildItemRow(context, cart, item);
                      },
                    ),
                  ],
                ),
              ),
              _buildBottomSummary(subtotal, deliveryFee),
            ],
          );
        },
      ),
    );
  }

  Widget _buildItemRow(BuildContext context, CartViewModel cart, CartItem item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(item.food.image, width: 60, height: 60, fit: BoxFit.cover),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.food.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                Text("₦${item.food.price}", style: const TextStyle(color: Colors.grey, fontSize: 13)),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(icon: const Icon(Icons.remove_circle_outline), onPressed: () => cart.decrementQuantity(cart.items.indexOf(item))),
              Text("${item.quantity}", style: const TextStyle(fontWeight: FontWeight.bold)),
              IconButton(icon: const Icon(Icons.add_circle_outline), onPressed: () => cart.incrementQuantity(cart.items.indexOf(item))),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildBottomSummary(double subtotal, double deliveryFee) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: const BoxDecoration(color: Color(0xFFF3F4F6), borderRadius: BorderRadius.vertical(top: Radius.circular(35))),
      child: Column(
        children: [
          _summaryRow("Subtotal", "₦$subtotal"),
          _summaryRow("Delivery", "₦$deliveryFee"),
          const Divider(),
          _summaryRow("Total", "₦${subtotal + deliveryFee}", isTotal: true),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF7000)),
              child: const Text("Checkout", style: TextStyle(color: Colors.white)),
            ),
          )
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
          Text(value, style: TextStyle(fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }
}