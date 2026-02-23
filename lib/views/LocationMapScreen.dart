import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import '../viewmodels/LocationViewModel.dart';
import '../routes/AppRoutes.dart';

class LocationMapScreen extends StatefulWidget {
  const LocationMapScreen({super.key});

  @override
  State<LocationMapScreen> createState() => _LocationMapScreenState();
}

class _LocationMapScreenState extends State<LocationMapScreen> {
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    // Fetch user location as soon as the screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LocationViewModel>().getCurrentLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    final locationVM = context.watch<LocationViewModel>();

    return Scaffold(
      body: Stack(
        children: [
          // 1. The Map Layer
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              // Fallback to Abuja if location isn't ready yet
              initialCenter:
                  locationVM.currentPosition ?? const LatLng(9.0820, 7.4913),
              initialZoom: 15.0,
              onPositionChanged: (position, hasGesture) {
                // Update address when user stops dragging the map
                if (hasGesture && position.center != null) {
                  locationVM.getAddressFromLatLng(position.center!);
                }
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.chopchop.app',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: locationVM.currentPosition ??
                        const LatLng(9.0820, 7.4913),
                    width: 80,
                    height: 80,
                    child: const Icon(Icons.location_on,
                        color: Colors.red, size: 45),
                  ),
                ],
              ),
            ],
          ),

          // 2. The "Skip" button
          Positioned(
            top: 50,
            right: 20,
            child: TextButton(
              onPressed: () => AppRoutes.navigateTo(context, AppRoutes.login),
              style: TextButton.styleFrom(
                backgroundColor: Colors.orange.withOpacity(0.1),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
              child: const Text("skip",
                  style: TextStyle(
                      color: Colors.orange, fontWeight: FontWeight.bold)),
            ),
          ),

          // 3. Current Location FAB
          Positioned(
            bottom: 240,
            right: 20,
            child: FloatingActionButton(
              mini: true,
              backgroundColor: Theme.of(context).cardColor,
              onPressed: () async {
                await locationVM.getCurrentLocation();
                if (locationVM.currentPosition != null) {
                  _mapController.move(locationVM.currentPosition!, 15.0);
                }
              },
              child: Icon(Icons.my_location,
                  color: Theme.of(context).iconTheme.color),
            ),
          ),

          // 4. Bottom UI (Search bar & Confirmation)
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(30)),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 10)
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Are you having issues locating your address?\nTry searching manually instead",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  const SizedBox(height: 20),
                  // Search TextField
                  TextField(
                    controller: locationVM.addressController,
                    onChanged: (value) => locationVM.updateManualAddress(value),
                    onSubmitted: (value) {
                      // Navigate to details when user presses enter/search on keyboard
                      AppRoutes.navigateTo(context, AppRoutes.addressDetails);
                    },
                    decoration: InputDecoration(
                      hintText: "Search address, street or state",
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      filled: true,
                      fillColor:
                          Theme.of(context).inputDecorationTheme.fillColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
