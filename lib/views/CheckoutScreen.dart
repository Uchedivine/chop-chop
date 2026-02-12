import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/CheckoutViewModel.dart';
import '../routes/AppRoutes.dart';

class CheckoutScreen extends StatefulWidget {
  final String restaurantName;
  final double subtotal;
  final String? deliveryAddress;

  const CheckoutScreen({
    super.key,
    required this.restaurantName,
    required this.subtotal,
    this.deliveryAddress,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final TextEditingController _voucherController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final vm = Provider.of<CheckoutViewModel>(context, listen: false);
      vm.initialize(widget.subtotal, widget.deliveryAddress);
    });
  }

  @override
  void dispose() {
    _voucherController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
        title: const Text("Checkout", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Consumer<CheckoutViewModel>(
        builder: (context, vm, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Restaurant: ${widget.restaurantName}", 
                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.grey)),
                const SizedBox(height: 20),
                
                _buildSectionHeader("Delivery Address", onChange: () {
                  // Address logic placeholder
                }),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 100,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Color(0xFFF3F4F6),
                          borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                        ),
                        child: const Icon(Icons.map_outlined, size: 40, color: Colors.grey), 
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          children: [
                            const Icon(Icons.location_on, color: Color(0xFFFF9431)),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                vm.deliveryAddress,
                                style: const TextStyle(fontSize: 13, color: Colors.black87, height: 1.4),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                _buildSectionHeader("Payment Method", onChange: () async {
                  final selected = await AppRoutes.navigateToPaymentMethods(context, vm.paymentMethod);
                  if (selected != null && selected is String) {
                    vm.updatePaymentMethod(selected);
                  }
                }),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9FAFB),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        vm.paymentMethod.contains("Cash") ? Icons.handshake : Icons.credit_card, 
                        color: vm.paymentMethod.contains("Cash") ? Colors.green : Colors.blue, 
                        size: 30
                      ),
                      const SizedBox(width: 15),
                      Text(vm.paymentMethod, style: const TextStyle(fontWeight: FontWeight.w500)),
                      const Spacer(),
                      const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                const Text("Voucher", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _voucherController,
                        decoration: InputDecoration(
                          hintText: "Enter Voucher Code",
                          hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                          filled: true,
                          fillColor: const Color(0xFFF9FAFB),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () => vm.applyVoucher(_voucherController.text),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF9431),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                        elevation: 0,
                      ),
                      child: const Text("Apply", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    )
                  ],
                ),

                const SizedBox(height: 25),

                const Text("Tip Rider", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 5),
                const Text("All tips go directly to the delivery rider.", style: TextStyle(color: Colors.grey, fontSize: 11)),
                const SizedBox(height: 15),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [200, 500, 1000, 1500, 2000].map((amount) {
                      final isSelected = vm.tipAmount == amount;
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: ChoiceChip(
                          label: Text("₦$amount"),
                          selected: isSelected,
                          selectedColor: const Color(0xFFFF9431),
                          backgroundColor: Colors.white,
                          labelStyle: TextStyle(
                            color: isSelected ? Colors.white : Colors.grey, 
                            fontWeight: FontWeight.bold
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(color: isSelected ? const Color(0xFFFF9431) : Colors.grey.shade200)
                          ),
                          onSelected: (selected) => vm.setTip(selected ? amount.toDouble() : 0.0),
                        ),
                      );
                    }).toList(),
                  ),
                ),

                const SizedBox(height: 30),

                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F6),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      _buildSummaryRow("Cost of total items:", "₦${vm.subtotal.toStringAsFixed(0)}"),
                      const SizedBox(height: 12),
                      _buildSummaryRow("Delivery Fee:", "₦${vm.deliveryFee.toStringAsFixed(0)}"),
                      const SizedBox(height: 12),
                      _buildSummaryRow("Tip:", "₦${vm.tipAmount.toStringAsFixed(0)}"),
                      const SizedBox(height: 12),
                      _buildSummaryRow("Discount:", "- ₦${vm.discount.toStringAsFixed(0)}"),
                      const Divider(height: 30, color: Colors.white, thickness: 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Total Amount:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          Text("₦${vm.totalAmount.toStringAsFixed(0)}", 
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Color(0xFFFF9431))),
                        ],
                      ),
                      const SizedBox(height: 25),
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigating to Order Success with dynamic data
                            AppRoutes.navigateToOrderSuccess(
                              context, 
                              widget.restaurantName, 
                              "₦${vm.totalAmount.toStringAsFixed(0)}", 
                              vm.deliveryAddress
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFF9431),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            elevation: 0,
                          ),
                          child: const Text("Pay To Order", 
                            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          );
        }
      ),
    );
  }

  Widget _buildSectionHeader(String title, {required VoidCallback onChange}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        TextButton(
          onPressed: onChange,
          style: TextButton.styleFrom(
            backgroundColor: const Color(0xFFFFF1E4),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            padding: const EdgeInsets.symmetric(horizontal: 15),
          ),
          child: const Text("Change", style: TextStyle(color: Color(0xFFFF9431), fontSize: 12, fontWeight: FontWeight.bold)),
        )
      ],
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black)),
      ],
    );
  }
}