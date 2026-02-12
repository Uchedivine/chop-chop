import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/RestaurantDetailsViewModel.dart';
import '../models/MenuItem.dart';

class RestaurantDetailsScreen extends StatelessWidget {
  const RestaurantDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Extracting dynamic data passed from the Home Screen
    final Map<String, dynamic> restaurantData = 
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return ChangeNotifierProvider(
      create: (_) {
        final vm = RestaurantDetailsViewModel();
        vm.setRestaurantData(restaurantData);
        return vm;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Consumer<RestaurantDetailsViewModel>(
          builder: (context, vm, child) {
            return Stack(
              children: [
                // Background image that extends behind everything
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: 300,
                  child: Image.asset(
                    restaurantData['image'],
                    fit: BoxFit.cover,
                  ),
                ),
                
                // Scrollable content
                CustomScrollView(
                  slivers: [
                    // 1. Transparent app bar with action buttons
                    SliverAppBar(
                      expandedHeight: 200,
                      pinned: false,
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      leading: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: _buildCircularAction(
                          Icons.arrow_back_ios_new,
                          onPressed: () => Navigator.pop(context),
                          iconSize: 16,
                        ),
                      ),
                      actions: [
                        _buildCircularAction(Icons.search),
                        _buildCircularAction(Icons.favorite_border),
                        _buildCircularAction(Icons.more_horiz),
                        const SizedBox(width: 10),
                      ],
                    ),

                    // 2. Floating Info Card (The Overlay)
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          _buildOverlayInfoCard(vm),
                          const SizedBox(height: 20),
                          _buildCategoryTabs(vm),
                        ],
                      ),
                    ),

                    // 3. Current Category Title
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, top: 25, bottom: 10),
                        child: Text(
                          vm.categories[vm.selectedCategoryIndex],
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),

                    // 4. List of Menu Items with Dividers
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return Column(
                            children: [
                              _buildMenuItemTile(vm.filteredItems[index]),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Divider(height: 1, color: Color(0xFFEEEEEE)),
                              ),
                            ],
                          );
                        },
                        childCount: vm.filteredItems.length,
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildCircularAction(IconData icon, {VoidCallback? onPressed, double iconSize = 20}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
      child: IconButton(
        icon: Icon(icon, color: Colors.black, size: iconSize),
        onPressed: onPressed ?? () {},
      ),
    );
  }

  Widget _buildOverlayInfoCard(RestaurantDetailsViewModel vm) {
    final data = vm.restaurantData;
    if (data == null) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Restaurant logo and name
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  vm.getRestaurantLogo(),
                  width: 48,
                  height: 48,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                data['name'] ?? "Restaurant",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.3,
                  color: Color(0xFF1A1A1A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          // Badges row
          Row(
            children: [
              _buildFigmaBadge(Icons.star, data['rating'] ?? "5.0"),
              const SizedBox(width: 8),
              _buildFigmaBadge(Icons.local_shipping, "₦${data['price'] ?? '800'}"),
              const SizedBox(width: 8),
              _buildFigmaBadge(Icons.access_time, data['time'] ?? "15 - 20"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFigmaBadge(IconData icon, String text) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFFFF9431),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: Colors.white),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                text, 
                style: const TextStyle(
                  color: Colors.white, 
                  fontWeight: FontWeight.w600, 
                  fontSize: 13,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryTabs(RestaurantDetailsViewModel vm) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: List.generate(vm.categories.length, (index) {
          bool isSelected = vm.selectedCategoryIndex == index;
          return GestureDetector(
            onTap: () => vm.selectCategory(index),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isSelected ? const Color(0xFFFF9431) : Colors.transparent, 
                    width: 2,
                  ),
                ),
              ),
              child: Text(
                vm.categories[index], 
                style: TextStyle(
                  color: isSelected ? Colors.black : Colors.grey, 
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  fontSize: 15,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildMenuItemTile(MenuItem item) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(item.image, width: 110, height: 110, fit: BoxFit.cover),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(item.price, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    if (item.discount != null)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(6)),
                        child: Text(
                          item.discount!, 
                          style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  item.name, 
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF4A4A4A)),
                ),
                const SizedBox(height: 6),
                Text(
                  item.description, 
                  maxLines: 3, 
                  overflow: TextOverflow.ellipsis, 
                  style: const TextStyle(color: Colors.grey, fontSize: 11, height: 1.4),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Column(
            children: [
              const SizedBox(height: 80),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6), 
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.add, size: 24, color: Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }
}