import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'routes/AppRoutes.dart';
import 'utils/AppTheme.dart';
import 'viewmodels/OnboardingViewModel.dart';
import 'viewmodels/LanguageViewModel.dart';
import 'viewmodels/ThemeViewModel.dart';
import 'viewmodels/LoginViewModel.dart';
import 'viewmodels/OTPViewModel.dart';
import 'viewmodels/LocationViewModel.dart';
import 'viewmodels/home_view_model.dart';
import 'viewmodels/SearchViewModel.dart';
import 'viewmodels/NotificationsViewModel.dart';
import 'viewmodels/CartViewModel.dart';
import 'viewmodels/SupportViewModel.dart';

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
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => OTPViewModel()),
        ChangeNotifierProvider(create: (_) => LocationViewModel()),
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => SearchViewModel()),
        ChangeNotifierProvider(create: (_) => NotificationsViewModel()),
        ChangeNotifierProvider(create: (_) => CartViewModel()),
        ChangeNotifierProvider(create: (_) => SupportViewModel()),
      ],
      // Listens for theme changes to rebuild the app
      child: Consumer<ThemeViewModel>(
        builder: (context, themeViewModel, child) {
          return MaterialApp(
            title: 'Chop Chop',
            debugShowCheckedModeBanner: false,

            // Theme configuration
            themeMode: themeViewModel.themeMode,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,

            // Navigation configuration
            initialRoute: AppRoutes.splash,
            // Reverted to use the routes map for named route support
            routes: AppRoutes.getRoutes(),
          );
        },
      ),
    );
  }
}
