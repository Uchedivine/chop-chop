import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/NotificationsViewModel.dart';
import '../widgets/PrimaryButton.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final navVM = Provider.of<NotificationsViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(10)),
            child: const Icon(Icons.arrow_back_ios_new, size: 18, color: Colors.grey),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Notifications", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Custom Tab Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                _buildTab(context, "Order Updates", 0, navVM),
                _buildTab(context, "Others", 1, navVM),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: navVM.notifications.length,
              itemBuilder: (context, index) => _NotificationCard(notification: navVM.notifications[index]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(BuildContext context, String label, int index, NotificationsViewModel vm) {
    bool isSelected = vm.selectedTabIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => vm.setTabIndex(index),
        child: Column(
          children: [
            Text(label, style: TextStyle(color: isSelected ? Colors.orange : Colors.grey, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
            const SizedBox(height: 8),
            Container(height: 2, color: isSelected ? Colors.orange : Colors.grey[200]),
          ],
        ),
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final NotificationModel notification;
  const _NotificationCard({required this.notification});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: Colors.grey[50], borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStatusIcon(),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(notification.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        if (notification.isNew)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(color: Colors.orange[50], borderRadius: BorderRadius.circular(10)),
                            child: const Text("New", style: TextStyle(color: Colors.orange, fontSize: 12, fontWeight: FontWeight.bold)),
                          ),
                      ],
                    ),
                    Text(notification.time, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(notification.message, style: TextStyle(color: Colors.grey[700], fontSize: 13, height: 1.4)),
          if (notification.actionLabel != null) ...[
            const SizedBox(height: 15),
            PrimaryButton(text: notification.actionLabel!, onPressed: () {}),
          ]
        ],
      ),
    );
  }

  Widget _buildStatusIcon() {
    Color bgColor;
    IconData icon;
    Color iconColor;

    switch (notification.status) {
      case 'canceled': bgColor = Colors.red[50]!; icon = Icons.shopping_bag; iconColor = Colors.red; break;
      case 'delivered': bgColor = Colors.green[50]!; icon = Icons.shopping_bag; iconColor = Colors.green; break;
      case 'on-way': bgColor = Colors.orange[50]!; icon = Icons.local_shipping; iconColor = Colors.orange; break;
      case 'received': bgColor = Colors.blue[50]!; icon = Icons.shopping_bag; iconColor = Colors.blue; break;
      default: bgColor = Colors.green[50]!; icon = Icons.check_circle; iconColor = Colors.green;
    }

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
      child: Icon(icon, color: iconColor, size: 20),
    );
  }
}