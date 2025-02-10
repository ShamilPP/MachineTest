import 'package:ecommerce_machinetest/constants/app_theme.dart';
import 'package:ecommerce_machinetest/view/screens/splash/splash_screen.dart';
import 'package:ecommerce_machinetest/view_model/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductsProvider()),
      ],
      child: MaterialApp(
        theme: AppTheme.lightTheme,
        home: SplashScreen(),
      ),
    );
  }
}
