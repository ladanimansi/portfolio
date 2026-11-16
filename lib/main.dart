import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/core/constants/app_strings.dart';
import 'app/core/theme/app_theme.dart';
import 'app/modules/home/bindings/home_binding.dart';
import 'app/routes/app_pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '${AppStrings.developerName} | Portfolio',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      initialBinding: HomeBinding(),
      defaultTransition: Transition.fadeIn,
    );
  }
}
