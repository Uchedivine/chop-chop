import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/OrderSuccessViewModel.dart';
import '../routes/AppRoutes.dart';

class OrderSuccessScreen extends StatefulWidget {
  final String restaurantName;
  final String totalExpense;
  final String deliveryAddress;

  const OrderSuccessScreen({
    super.key,
    required this.restaurantName,
    required this.totalExpense,
    required this.deliveryAddress,
  });

  @override
  State<OrderSuccessScreen> createState() => _OrderSuccessScreenState();
}

class _OrderSuccessScreenState extends State<OrderSuccessScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<OrderSuccessViewModel>(context, listen: false)
          .generateOrderDetails();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<OrderSuccessViewModel>(
        builder: (context, vm, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 60),
            child: Column(
              children: [
                // Illustration Section
                Center(
                  child: Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).cardColor,
                    ),
                    child: const Icon(Icons.delivery_dining,
                        size: 100, color: Color(0xFFFF9431)),
                  ),
                ),
                const SizedBox(height: 30),
                const Text("Enjoyment Galore!",
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Text(
                  "Your order to ${widget.restaurantName} has been completed and is on its way",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 40),

                // Order Summary Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Order Summary",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 15),
                      _buildInfoRow("Order Number:", vm.orderNumber),
                      _buildInfoRow("Total Expense:", widget.totalExpense),
                      _buildInfoRow(
                          "Delivery Address:", widget.deliveryAddress),
                      _buildInfoRow(
                          "Estimated Delivery Time:", vm.estimatedTime),
                    ],
                  ),
                ),
                const SizedBox(height: 50),

                // Action Buttons
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to Track Order with dynamic data
                      AppRoutes.navigateToTrackOrder(
                          context, widget.deliveryAddress, vm.estimatedTime);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF9431),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text("Track Order",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: OutlinedButton(
                    onPressed: () => AppRoutes.navigateToAndRemoveUntil(
                        context, AppRoutes.home),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFFF9431)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text("Return To Homepage",
                        style: TextStyle(
                            color: Color(0xFFFF9431),
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 13)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(value,
                textAlign: TextAlign.end,
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
          ),
        ],
      ),
    );
  }
}
