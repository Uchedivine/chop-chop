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
      appBar: AppBar(
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.arrow_back_ios_new,
                  color: Theme.of(context).iconTheme.color, size: 18),
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
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Icon(Icons.map_sharp,
                        size: 100, color: Theme.of(context).disabledColor),
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
                        Text("Estimated Delivery Time:",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold)),
                        Text("Arriving at $estimatedTime",
                            style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                          color: Colors.red, shape: BoxShape.circle),
                      child: const Text("SOS",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10)),
                    )
                  ],
                ),
                const SizedBox(height: 30),

                // Order Status Stepper
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildStatusStep(context, vm, OrderStatus.confirmed,
                        Icons.check_circle, "Order Confirmed"),
                    _buildStatusStep(context, vm, OrderStatus.received,
                        Icons.shopping_bag, "Order Recieved"),
                    _buildStatusStep(context, vm, OrderStatus.onTheWay,
                        Icons.delivery_dining, "On The Way"),
                    _buildStatusStep(context, vm, OrderStatus.delivered,
                        Icons.home_work, "Order Delivered"),
                  ],
                ),
                const SizedBox(height: 30),

                // Driver Info Card
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                          radius: 25,
                          backgroundColor: Theme.of(context).disabledColor),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(vm.driverName,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(fontWeight: FontWeight.bold)),
                            Row(
                              children: [
                                const Icon(Icons.star,
                                    color: Colors.orange, size: 14),
                                Text(" ${vm.driverRating} (${vm.totalReviews})",
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
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
                Text("Delivery Address",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on, color: Color(0xFFFF9431)),
                      const SizedBox(width: 10),
                      Expanded(
                          child: Text(deliveryAddress,
                              style: Theme.of(context).textTheme.bodySmall)),
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

  Widget _buildStatusStep(BuildContext context, TrackOrderViewModel vm,
      OrderStatus status, IconData icon, String label) {
    bool isDone = vm.isStepCompleted(status);
    return Column(
      children: [
        Icon(icon,
            color: isDone ? const Color(0xFFFF9431) : Colors.grey, size: 30),
        const SizedBox(height: 5),
        Text(label,
            style: TextStyle(
                fontSize: 10,
                color: isDone
                    ? const Color(0xFFFF9431)
                    : Theme.of(context).disabledColor)),
      ],
    );
  }
}
