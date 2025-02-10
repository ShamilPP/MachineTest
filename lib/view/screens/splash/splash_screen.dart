import 'package:ecommerce_machinetest/view/navigation/home_main_view.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 150,
          height: 150,
          child: Image.asset(AppImages.icon),
        ),
      ),
    );
  }

  void init() {
    Future.delayed(Duration(milliseconds: 500)).then((value) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeMainView()));
    });
  }
}
