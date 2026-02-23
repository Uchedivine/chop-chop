import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/FavoritesViewModel.dart';
import '../widgets/RestaurantCard.dart';
import '../routes/AppRoutes.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesVM = Provider.of<FavoritesViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Favorites",
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Theme.of(context).iconTheme.color),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.searchRoute);
            },
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(context),
      body: favoritesVM.favoriteRestaurants.isEmpty
          ? _buildEmptyState(context) // Pass context to _buildEmptyState
          : _buildFavoritesList(context, favoritesVM),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    // Added BuildContext context parameter
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 64,
            color: Theme.of(context).disabledColor,
          ),
          const SizedBox(height: 16),
          Text(
            "No favorites yet",
            style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).textTheme.bodyLarge?.color,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Explore restaurants and add them to your favorites!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).textTheme.bodySmall?.color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoritesList(
      BuildContext context, FavoritesViewModel viewModel) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      itemCount: viewModel.favoriteRestaurants.length,
      itemBuilder: (context, index) {
        final restaurant = viewModel.favoriteRestaurants[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.restaurantDetails,
                arguments: restaurant,
              );
            },
            child: RestaurantCard(
              image: restaurant['image'],
              name: restaurant['name'],
              rating: restaurant['rating'],
              price: restaurant['price'] ?? "1,000",
              time: restaurant['time'] ?? "15-20 min",
              isFavorite: true,
              onFavoriteToggle: () {
                viewModel.toggleFavorite(restaurant);
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 3, // Favorites tab is active
      onTap: (index) {
        if (index == 0) {
          Navigator.pushNamedAndRemoveUntil(
              context, AppRoutes.home, (route) => false);
        } else if (index == 4) {
          Navigator.pushNamed(context, AppRoutes.profile);
        } else if (index != 3) {
          // Handle other tabs if necessary
          debugPrint("Tap index: $index");
        }
      },
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Theme.of(context).primaryColor, // Use theme color
      unselectedItemColor: Theme.of(context).disabledColor, // Use theme color
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
