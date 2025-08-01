import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:medipoint_machine_test/view/auth/login_view.dart';
import 'package:medipoint_machine_test/view/home_view.dart';
import 'package:medipoint_machine_test/core/utils/app_size.dart';

class SplashView extends StatefulWidget {
  static const String routeName = "splashView";
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _navigateFromSplash();
  }

  Future<void> _navigateFromSplash() async {
    try {
      // Wait 3 seconds for splash
      await Future.delayed(Duration(seconds: 3));

      // Fetch token
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");

      print("Retrieved token: $token");

      if (!mounted) return; // Widget might be disposed

      // Navigate based on token
      if (token != null && token.isNotEmpty) {
        Navigator.pushReplacementNamed(context, HomeView.routeName);
      } else {
        Navigator.pushReplacementNamed(context, LoginView.routeName);
      }
    } catch (e) {
      print("Error in splash navigation: $e");
      if (mounted) {
        Navigator.pushReplacementNamed(context, LoginView.routeName);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: screenHeight(context, 1),
        width: screenWidth(context, 1),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/splash_screen.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
