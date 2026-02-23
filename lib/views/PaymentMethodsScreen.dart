import 'package:flutter/material.dart';

class PaymentMethod {
  final String name;
  final IconData icon;
  final Color iconColor;

  PaymentMethod(this.name, this.icon, this.iconColor);
}

class PaymentMethodsScreen extends StatefulWidget {
  final String currentMethod;

  const PaymentMethodsScreen({super.key, required this.currentMethod});

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  late String _selectedMethod;

  final List<PaymentMethod> _methods = [
    PaymentMethod("Credit/Debit Card", Icons.credit_card, Colors.red),
    PaymentMethod("In-App Wallet", Icons.account_balance_wallet, Colors.orange),
    PaymentMethod("Cash On Delivery", Icons.handshake, Colors.green),
    PaymentMethod("Bank Transfer", Icons.account_balance, Colors.blue),
  ];

  @override
  void initState() {
    super.initState();
    _selectedMethod = widget.currentMethod;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new,
              color: Theme.of(context).iconTheme.color, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Payment Methods",
            style: Theme.of(context).appBarTheme.titleTextStyle),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Add New Card Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Add a new Debit/Credit Card",
                    style: Theme.of(context).textTheme.bodyMedium),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.add, color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 10),

            // List of Methods
            Expanded(
              child: ListView.separated(
                itemCount: _methods.length,
                separatorBuilder: (_, __) => const SizedBox(height: 15),
                itemBuilder: (context, index) {
                  final method = _methods[index];
                  final isSelected = _selectedMethod.contains(method.name);

                  return GestureDetector(
                    onTap: () => setState(() => _selectedMethod = method.name),
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFFFF9431)
                              : Theme.of(context).dividerColor,
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(method.icon, color: method.iconColor, size: 28),
                          const SizedBox(width: 15),
                          Text(method.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(fontWeight: FontWeight.w500)),
                          const Spacer(),
                          Icon(
                            isSelected
                                ? Icons.radio_button_checked
                                : Icons.radio_button_off,
                            color: isSelected
                                ? const Color(0xFFFF9431)
                                : Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Select Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context, _selectedMethod),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF9431),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
                child: const Text("Select",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
