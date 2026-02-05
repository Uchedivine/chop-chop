import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'utils/AppTheme.dart';
import 'routes/AppRoutes.dart';
import 'viewmodels/OnboardingViewModel.dart';
import 'viewmodels/LanguageViewModel.dart';
import 'viewmodels/ThemeViewModel.dart';

void main() {
  runApp(const ChopChopApp());
}

class ChopChopApp extends StatelessWidget {
  const ChopChopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OnboardingViewModel()),
        ChangeNotifierProvider(create: (_) => LanguageViewModel()),
        ChangeNotifierProvider(create: (_) => ThemeViewModel()),
      ],
      // WRAP MaterialApp with Consumer to listen for changes
      child: Consumer<ThemeViewModel>(
        builder: (context, themeViewModel, child) {
          return MaterialApp(
            title: 'Chop Chop',
            debugShowCheckedModeBanner: false,
            
            // 1. Bind the current theme mode to the ViewModel
            themeMode: themeViewModel.themeMode, 
            
            // 2. Define your themes
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            
            initialRoute: AppRoutes.splash,
            routes: AppRoutes.getRoutes(),
          );
        },
      ),
    );
  }
}