import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/LocationViewModel.dart';
import '../widgets/PrimaryButton.dart';
import '../routes/AppRoutes.dart';

class AddressDetailsScreen extends StatelessWidget {
  const AddressDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Watch the LocationViewModel for changes in selection
    final locationVM = context.watch<LocationViewModel>();
    
    // The list of building types from your design
    final List<String> buildingTypes = [
      'House',
      'Apartment',
      'Office',
      'Hostel',
      'Hotel'
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Address Details",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            
            // 1. Display the geocoded address from the map
            Row(
              children: [
                const Icon(Icons.location_on_outlined, color: Colors.orange, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    locationVM.currentAddress,
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // 2. Additional Info Input
            TextField(
              decoration: InputDecoration(
                hintText: "Additional Information",
                hintStyle: TextStyle(color: Colors.grey[400]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
            ),
            const SizedBox(height: 32),

            const Text(
              "Choose Building Type",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // 3. Dynamic Building Type List
            Expanded(
              child: ListView.builder(
                itemCount: buildingTypes.length,
                itemBuilder: (context, index) {
                  final type = buildingTypes[index];
                  final bool isSelected = locationVM.selectedBuildingType == type;

                  return GestureDetector(
                    onTap: () => locationVM.setBuildingType(type),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        // Orange border if selected, otherwise grey
                        border: Border.all(
                          color: isSelected ? Colors.orange : Colors.grey.shade200,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            type,
                            style: TextStyle(
                              fontSize: 16,
                              color: isSelected ? Colors.black : Colors.grey[600],
                            ),
                          ),
                          // Radio icon state
                          Icon(
                            isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                            color: isSelected ? Colors.orange : Colors.grey[300],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // 4. Save Button
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: PrimaryButton(
                text: "Save Address",
                onPressed: () {
                  // Navigate to Register or Home after saving
                  AppRoutes.navigateTo(context, AppRoutes.register);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}