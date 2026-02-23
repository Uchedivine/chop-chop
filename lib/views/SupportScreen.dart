import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/SupportViewModel.dart';
import '../viewmodels/ThemeViewModel.dart';
import '../routes/AppRoutes.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeVM = Provider.of<ThemeViewModel>(context);
    final supportVM = Provider.of<SupportViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.arrow_back_ios_new,
                  color: Theme.of(context).iconTheme.color, size: 18),
            ),
          ),
        ),
        title: Text("Support",
            style: Theme.of(context).appBarTheme.titleTextStyle),
        centerTitle: true,
      ),
      bottomNavigationBar: _buildBottomNavBar(context),
      body: Column(
        children: [
          Expanded(
            child: supportVM.messages.isEmpty
                ? _buildSuggestionsGrid(context, supportVM)
                : _buildChatList(supportVM),
          ),
          _buildMessageInput(context, supportVM, themeVM),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 2, // Support tab is active
      onTap: (index) {
        if (index == 0) {
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        } else if (index == 4) {
          Navigator.pushNamed(context, AppRoutes.profile);
        } else if (index != 2) {
          // Add navigation for other tabs if needed
          debugPrint("Tap index: $index");
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

  Widget _buildSuggestionsGrid(
      BuildContext context, SupportViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.2,
        ),
        itemCount: viewModel.suggestions.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () =>
                viewModel.onSuggestionTap(viewModel.suggestions[index]),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .secondaryContainer, // Replaced hardcoded color
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  viewModel.suggestions[index],
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500), // Replaced hardcoded color
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildChatList(SupportViewModel viewModel) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: viewModel.messages.length,
      itemBuilder: (context, index) {
        final message = viewModel.messages[index];
        return Align(
          alignment:
              message.isUser ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: message.isUser ? Colors.orange : Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              message.text,
              style: TextStyle(
                color: message.isUser ? Colors.white : Colors.black87,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMessageInput(BuildContext context, SupportViewModel viewModel,
      ThemeViewModel themeVM) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: themeVM.isDarkMode ? Colors.black : Colors.white,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: themeVM.isDarkMode ? Colors.grey[900] : Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: viewModel.messageController,
                      decoration: const InputDecoration(
                        hintText: "What do you need?",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Icon(Icons.mic_none, color: Colors.grey[600]),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () =>
                viewModel.sendMessage(viewModel.messageController.text),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFDB574), // Lighter orange for the button
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.send_outlined, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
