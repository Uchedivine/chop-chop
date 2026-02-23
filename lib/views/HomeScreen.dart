import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/LocationViewModel.dart';
import '../viewmodels/home_view_model.dart';
import '../viewmodels/CartViewModel.dart';
import '../viewmodels/FavoritesViewModel.dart';
import '../widgets/CategoryItem.dart';
import '../widgets/RestaurantCard.dart';

import '../routes/AppRoutes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _bannerController;
  int _currentPage = 0;
  int _selectedNavIndex = 0;

  @override
  void initState() {
    super.initState();
    _bannerController = PageController(viewportFraction: 0.9);
  }

  @override
  void dispose() {
    _bannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locationVM = Provider.of<LocationViewModel>(context);
    final homeVM = Provider.of<HomeViewModel>(context);
    // Listen to the CartViewModel to update the counter badge in real-time
    final cartVM = Provider.of<CartViewModel>(context);
    final favoritesVM = Provider.of<FavoritesViewModel>(context);

    return Scaffold(
      bottomNavigationBar: _buildBottomNavBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context, locationVM.currentAddress, cartVM),
              _buildSearchBar(context),
              const SizedBox(height: 20),
              _buildBannerCarousel(homeVM.banners),
              _buildSectionHeader("Categories"),
              _buildCategoryList(homeVM.categories),
              _buildSectionHeader("Popular Restaurants", showSeeAll: true),
              _buildRestaurantList(context, homeVM.restaurants, favoritesVM),
              _buildSectionHeader("Fastest Deliveries", showSeeAll: true),
              _buildRestaurantList(context, homeVM.restaurants, favoritesVM),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // --- 1:1 UI Helper Widgets ---

  Widget _buildHeader(
      BuildContext context, String address, CartViewModel cartVM) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.orange.withOpacity(0.1),
            child:
                const Icon(Icons.location_on, color: Colors.orange, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Delivery Address:",
                    style: Theme.of(context).textTheme.bodySmall),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        address.isEmpty
                            ? "Obafemi Awolowo Road, Abuja"
                            : address,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Icon(Icons.keyboard_arrow_down, size: 20),
                  ],
                ),
              ],
            ),
          ),
          // --- Updated Cart Icon with Navigation ---
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.cart);
            },
            child: _buildHeaderIcon(
              Icons.shopping_cart_outlined,
              // Passing the actual count from the ViewModel
              // If cart is empty, we pass null so the badge is hidden
              count:
                  cartVM.items.isEmpty ? null : cartVM.items.length.toString(),
            ),
          ),
          const SizedBox(width: 15),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.notifications);
            },
            child: _buildHeaderIcon(Icons.notifications_none, count: "5"),
          ),
          const SizedBox(width: 15),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.profile);
            },
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Theme.of(context).cardColor,
              child: Icon(Icons.person_outline,
                  color: Theme.of(context).iconTheme.color, size: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderIcon(IconData icon, {String? count}) {
    return Stack(
      clipBehavior:
          Clip.none, // Allows the badge to sit slightly outside the icon frame
      children: [
        Icon(icon, color: Theme.of(context).iconTheme.color),
        if (count != null)
          Positioned(
            right: -4,
            top: -4,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(
                  color: Colors.red, shape: BoxShape.circle),
              constraints: const BoxConstraints(minWidth: 14, minHeight: 14),
              child: Text(
                count,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.searchRoute);
        },
        child: AbsorbPointer(
          child: TextField(
            decoration: InputDecoration(
              hintText: "Wetin you want chop today?",
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              filled: true,
              fillColor: Theme.of(context).cardColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBannerCarousel(List<String> banners) {
    return Column(
      children: [
        SizedBox(
          height: 160,
          child: PageView.builder(
            controller: _bannerController,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemCount: banners.length,
            itemBuilder: (context, index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    image: AssetImage(banners[index]), fit: BoxFit.cover),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(banners.length, (index) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 4,
              width: _currentPage == index ? 24 : 12,
              decoration: BoxDecoration(
                color: _currentPage == index
                    ? Colors.orange
                    : Colors.orange.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildCategoryList(List<Map<String, String>> categories) {
    return SizedBox(
      height: 115,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return CategoryItem(
            iconPath: categories[index]['icon']!,
            name: categories[index]['name']!,
          );
        },
      ),
    );
  }

  Widget _buildRestaurantList(BuildContext context,
      List<Map<String, dynamic>> restaurants, FavoritesViewModel favoritesVM) {
    return SizedBox(
      height: 240,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: restaurants.length,
        itemBuilder: (context, index) {
          final data = restaurants[index];

          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.restaurantDetails,
                arguments: data,
              );
            },
            child: RestaurantCard(
              image: data['image'],
              name: data['name'],
              rating: data['rating'],
              price: data['price'] ?? "1,000",
              time: data['time'] ?? "15-20 min",
              isFavorite: favoritesVM.isFavorite(data),
              onFavoriteToggle: () {
                favoritesVM.toggleFavorite(data);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(String title, {bool showSeeAll = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          if (showSeeAll)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12)),
              child: const Text("See All",
                  style: TextStyle(
                      color: Colors.orange,
                      fontSize: 12,
                      fontWeight: FontWeight.bold)),
            ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      currentIndex: _selectedNavIndex,
      onTap: (index) {
        if (index == 2) {
          Navigator.pushNamed(context, AppRoutes.support);
        } else if (index == 3) {
          Navigator.pushNamed(context, AppRoutes.favorites);
        } else if (index == 4) {
          Navigator.pushNamed(context, AppRoutes.profile);
        } else {
          setState(() => _selectedNavIndex = index);
        }
      },
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.orange,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      selectedLabelStyle:
          const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
      unselectedLabelStyle: const TextStyle(fontSize: 10),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
        BottomNavigationBarItem(
            icon: Icon(Icons.assignment_outlined), label: "Orders"),
        BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline), label: "Support"),
        BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border), label: "Favorites"),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline), label: "Profile"),
      ],
    );
  }
}
