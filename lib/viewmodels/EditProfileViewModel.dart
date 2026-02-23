import 'package:flutter/material.dart';

class EditProfileViewModel extends ChangeNotifier {
  final TextEditingController firstNameController =
      TextEditingController(text: "Emmanuel");
  final TextEditingController lastNameController =
      TextEditingController(text: "Isiguzo");
  final TextEditingController emailController =
      TextEditingController(text: "emmanuelisigozo2002@gmail.com");
  final TextEditingController phoneController =
      TextEditingController(text: "09068556889");
  final TextEditingController dobController =
      TextEditingController(text: "17/09/1997");

  final String userInitials = "EI";
  final String userName = "Emmanuel Isiguzo";
  final String userEmail = "emmanuelisigozo2002@gmail.com";

  void saveChanges(BuildContext context) {
    // Implement save logic here (e.g., API call)
    // For now, just show a success message and go back
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Changes saved successfully!")),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    dobController.dispose();
    super.dispose();
  }
}
