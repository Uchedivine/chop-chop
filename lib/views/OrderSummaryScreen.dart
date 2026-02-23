import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/CartViewModel.dart';
import '../viewmodels/CheckoutViewModel.dart';
import 'CheckoutScreen.dart';

class OrderSummaryScreen extends StatelessWidget {
  final String restaurantName;
  final List<CartItem> restaurantItems;

  const OrderSummaryScreen(
      {super.key, required this.restaurantName, required this.restaurantItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new,
              color: Theme.of(context).iconTheme.color, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Order Summary",
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        centerTitle: true,
      ),
      body: Consumer<CartViewModel>(
        builder: (context, cart, child) {
          // Re-filter items for this restaurant
          final currentItems = cart.items
              .where((item) => item.food.restaurantName == restaurantName)
              .toList();

          if (currentItems.isEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pop(context);
            });
            return const Center(child: Text("No items for this restaurant"));
          }

          double subtotal = currentItems.fold(0, (sum, item) {
            final price = double.tryParse(
                    item.food.price.replaceAll(RegExp(r'[^0-9]'), '')) ??
                0;
            return sum + (price * item.quantity);
          });
          const double deliveryFee = 900;

          return Column(
            children: [
              Expanded(
                child: ListView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  children: [
                    // Restaurant Header Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Restaurant: $restaurantName",
                            style:
                                const TextStyle(fontWeight: FontWeight.w500)),
                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: const Text("Clear Cart"),
                                content: Text(
                                  "Remove all items from $restaurantName?",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(ctx),
                                    child: const Text(
                                      "Cancel",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      cart.clearRestaurantFromCart(
                                          restaurantName);
                                      Navigator.pop(ctx);
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      "Remove",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          icon: const Icon(Icons.delete_outline,
                              color: Colors.red),
                        ),
                      ],
                    ),

                    const SizedBox(height: 5),
                    const Text(
                      "Add More Items",
                      style: TextStyle(
                        color: Color(0xFFFF9431),
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Items List
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: currentItems.length,
                      separatorBuilder: (_, __) => const Divider(height: 20),
                      itemBuilder: (context, index) {
                        final item = currentItems[index];
                        return _buildItemRow(context, cart, item);
                      },
                    ),
                  ],
                ),
              ),

              // Bottom Summary Section
              _buildBottomSummary(context, subtotal, deliveryFee),
            ],
          );
        },
      ),
    );
  }

  Widget _buildItemRow(
      BuildContext context, CartViewModel cart, CartItem item) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(item.food.image,
              width: 65, height: 65, fit: BoxFit.cover),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.food.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 15)),
              const SizedBox(height: 4),
              Text(item.food.price,
                  style: const TextStyle(color: Colors.grey, fontSize: 13)),
            ],
          ),
        ),
        // Quantity Controls
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove, size: 16),
                onPressed: () =>
                    cart.decrementQuantity(cart.items.indexOf(item)),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
              ),
              Text("${item.quantity}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15)),
              IconButton(
                icon: const Icon(Icons.add, size: 16),
                onPressed: () =>
                    cart.incrementQuantity(cart.items.indexOf(item)),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomSummary(
      BuildContext context, double subtotal, double deliveryFee) {
    double totalAmount = subtotal + deliveryFee;

    return Container(
      padding: const EdgeInsets.fromLTRB(25, 25, 25, 35),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(35))),
      child: Column(
        children: [
          _summaryRow(context, "Cost of total items:",
              "₦${subtotal.toStringAsFixed(0)}"),
          _summaryRow(
              context, "Delivery Fee:", "₦${deliveryFee.toStringAsFixed(0)}"),
          _summaryRow(context, "Discount:", "-"),
          const Divider(height: 30),
          _summaryRow(
              context, "Total Amount:", "₦${totalAmount.toStringAsFixed(0)}",
              isTotal: true),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: () {
                // Get the current delivery address from CheckoutViewModel if available
                final checkoutVm =
                    Provider.of<CheckoutViewModel>(context, listen: false);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CheckoutScreen(
                      restaurantName: restaurantName,
                      subtotal: subtotal,
                      // Pass the dynamic address from CheckoutViewModel
                      deliveryAddress: checkoutVm.deliveryAddress,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF9431),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
              child: const Text("Proceed to Checkout",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
            ),
          )
        ],
      ),
    );
  }

  Widget _summaryRow(BuildContext context, String label, String value,
      {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                fontSize: isTotal ? 16 : 14,
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                color: isTotal
                    ? Theme.of(context).textTheme.bodyLarge?.color
                    : Theme.of(context).textTheme.bodyMedium?.color,
              )),
          Text(value,
              style: TextStyle(
                fontSize: isTotal ? 18 : 14,
                fontWeight: FontWeight.bold,
                color: isTotal
                    ? const Color(0xFFFF9431)
                    : Theme.of(context).textTheme.bodyLarge?.color,
              )),
        ],
      ),
    );
  }
}
