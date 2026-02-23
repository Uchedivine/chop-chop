import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/EditProfileViewModel.dart';
import '../widgets/PrimaryButton.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EditProfileViewModel(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.arrow_back_ios_new,
                    color: Theme.of(context).iconTheme.color, size: 16),
              ),
            ),
          ),
          title: Text(
            "Edit Profile",
            style: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
                  fontSize: 18,
                ),
          ),
          centerTitle: false,
        ),
        body: Consumer<EditProfileViewModel>(
          builder: (context, viewModel, child) {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        _buildProfileHeader(context, viewModel),
                        const SizedBox(height: 30),
                        _buildTextField(
                          context,
                          label: "First Name*",
                          controller: viewModel.firstNameController,
                        ),
                        _buildTextField(
                          context,
                          label: "Last Name*",
                          controller: viewModel.lastNameController,
                        ),
                        _buildTextField(
                          context,
                          label: "E-mail Address*",
                          controller: viewModel.emailController,
                        ),
                        _buildTextField(
                          context,
                          label: "Phone Number*",
                          controller: viewModel.phoneController,
                        ),
                        _buildTextField(
                          context,
                          label: "Date of Birth",
                          controller: viewModel.dobController,
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: PrimaryButton(
                    text: "Save Changes",
                    onPressed: () => viewModel.saveChanges(context),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildProfileHeader(
      BuildContext context, EditProfileViewModel viewModel) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: const Color(0xFFFFEAD1),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.orange, width: 2),
              ),
              child: Center(
                child: Text(
                  viewModel.userInitials,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Text(
          viewModel.userName,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 5),
        Text(
          viewModel.userEmail,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget _buildTextField(
    BuildContext context, {
    required String label,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            style: Theme.of(context).textTheme.bodyLarge,
            decoration: const InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            ),
          ),
        ],
      ),
    );
  }
}
