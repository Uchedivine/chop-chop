import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';

class LocationViewModel extends ChangeNotifier {
  LatLng? _currentPosition;
  String _currentAddress = "Searching for address...";
  bool _isLoading = false;
  String _selectedBuildingType = 'House';

  // Controller for the manual search field in the UI
  final TextEditingController addressController = TextEditingController();

  LatLng? get currentPosition => _currentPosition;
  String get currentAddress => _currentAddress;
  bool get isLoading => _isLoading;
  String get selectedBuildingType => _selectedBuildingType;

  /// Updates the address manually from text input
  void updateManualAddress(String newAddress) {
    _currentAddress = newAddress;
    notifyListeners();
  }

  /// Sets the building type (House, Office, etc.)
  void setBuildingType(String type) {
    _selectedBuildingType = type;
    notifyListeners();
  }

  /// Step 1: Request Permission and get GPS Coordinates
  Future<void> getCurrentLocation() async {
    _isLoading = true;
    notifyListeners();

    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.whileInUse || 
          permission == LocationPermission.always) {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        
        _currentPosition = LatLng(position.latitude, position.longitude);
        await getAddressFromLatLng(_currentPosition!);
      }
    } catch (e) {
      debugPrint("Location Error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Step 2: Reverse Geocoding (Turns Lat/Long into a readable string)
  Future<void> getAddressFromLatLng(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        // Formatting to match the "Address Details" top row
        _currentAddress = "${place.street}, ${place.subLocality}, ${place.locality}";
        
        // Update the controller so the text appears in the search bar
        addressController.text = _currentAddress;
      }
    } catch (e) {
      _currentAddress = "Address not found";
    }
    notifyListeners();
  }

  @override
  void dispose() {
    addressController.dispose();
    super.dispose();
  }
}