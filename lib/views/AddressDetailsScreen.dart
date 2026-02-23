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
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,
              color: Theme.of(context).iconTheme.color, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Address Details",
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // 1. Display the geocoded address from the map
            Row(
              children: [
                const Icon(Icons.location_on_outlined,
                    color: Colors.orange, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    locationVM.currentAddress,
                    style: Theme.of(context).textTheme.bodyMedium,
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

            Text(
              "Choose Building Type",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // 3. Dynamic Building Type List
            Expanded(
              child: ListView.builder(
                itemCount: buildingTypes.length,
                itemBuilder: (context, index) {
                  final type = buildingTypes[index];
                  final bool isSelected =
                      locationVM.selectedBuildingType == type;

                  return GestureDetector(
                    onTap: () => locationVM.setBuildingType(type),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(12),
                        // Orange border if selected, otherwise separator color
                        border: Border.all(
                          color: isSelected
                              ? Colors.orange
                              : Theme.of(context).dividerColor,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            type,
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: isSelected
                                          ? Colors.orange
                                          : Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.color,
                                    ),
                          ),
                          // Radio icon state
                          Icon(
                            isSelected
                                ? Icons.radio_button_checked
                                : Icons.radio_button_off,
                            color:
                                isSelected ? Colors.orange : Colors.grey[300],
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
                  // Navigate to Food Preference screen after saving
                  AppRoutes.navigateTo(context, AppRoutes.foodPreference);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
