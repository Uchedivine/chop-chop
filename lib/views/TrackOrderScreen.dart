import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/TrackOrderViewModel.dart';

class TrackOrderScreen extends StatelessWidget {
  final String deliveryAddress;
  final String estimatedTime;

  const TrackOrderScreen({
    super.key,
    required this.deliveryAddress,
    required this.estimatedTime,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 18),
            ),
          ),
        ),
      ),
      body: Consumer<TrackOrderViewModel>(
        builder: (context, vm, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Map Placeholder Section
                Container(
                  height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9FAFB),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Icon(Icons.map_sharp, size: 100, color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 20),

                // Delivery Time & SOS
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Estimated Delivery Time:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        Text("Arriving at $estimatedTime", style: const TextStyle(color: Colors.grey, fontSize: 13)),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                      child: const Text("SOS", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10)),
                    )
                  ],
                ),
                const SizedBox(height: 30),

                // Order Status Stepper
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildStatusStep(vm, OrderStatus.confirmed, Icons.check_circle, "Order Confirmed"),
                    _buildStatusStep(vm, OrderStatus.received, Icons.shopping_bag, "Order Recieved"),
                    _buildStatusStep(vm, OrderStatus.onTheWay, Icons.delivery_dining, "On The Way"),
                    _buildStatusStep(vm, OrderStatus.delivered, Icons.home_work, "Order Delivered"),
                  ],
                ),
                const SizedBox(height: 30),

                // Driver Info Card
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9FAFB),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(radius: 25, backgroundColor: Colors.grey),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(vm.driverName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                            Row(
                              children: [
                                const Icon(Icons.star, color: Colors.orange, size: 14),
                                Text(" ${vm.driverRating} (${vm.totalReviews})", style: const TextStyle(color: Colors.grey, fontSize: 12)),
                              ],
                            )
                          ],
                        ),
                      ),
                      const Icon(Icons.phone_in_talk, color: Color(0xFFFF9431)),
                      const SizedBox(width: 15),
                      const Icon(Icons.chat_bubble, color: Color(0xFFFF9431)),
                    ],
                  ),
                ),
                const SizedBox(height: 25),

                // Delivery Address
                const Text("Delivery Address", style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9FAFB),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on, color: Color(0xFFFF9431)),
                      const SizedBox(width: 10),
                      Expanded(child: Text(deliveryAddress, style: const TextStyle(fontSize: 13))),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatusStep(TrackOrderViewModel vm, OrderStatus status, IconData icon, String label) {
    bool isDone = vm.isStepCompleted(status);
    return Column(
      children: [
        Icon(icon, color: isDone ? const Color(0xFFFF9431) : Colors.grey, size: 30),
        const SizedBox(height: 5),
        Text(label, style: TextStyle(fontSize: 10, color: isDone ? const Color(0xFFFF9431) : Colors.grey)),
      ],
    );
  }
}