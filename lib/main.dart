import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'utils/AppTheme.dart';
import 'routes/AppRoutes.dart';
import 'viewmodels/OnboardingViewModel.dart';

void main() {
  runApp(const ChopChopApp());
}

class ChopChopApp extends StatelessWidget {
  const ChopChopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Add OnboardingViewModel provider
        ChangeNotifierProvider(create: (_) => OnboardingViewModel()),
        // Add other ViewModels here as you create them
      ],
      child: MaterialApp(
        title: 'Chop Chop',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        
        // Set the initial route to Splash
        initialRoute: AppRoutes.splash,
        // Pass the routes map from our helper class
        routes: AppRoutes.getRoutes(),
      ),
    );
  }
}