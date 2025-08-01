import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:medipoint_machine_test/core/app_theme/app_colors.dart';
import 'package:medipoint_machine_test/provider/dashboard_provider.dart';
import 'package:medipoint_machine_test/provider/login_provider.dart';
import 'package:medipoint_machine_test/provider/register_provider.dart';
import 'package:medipoint_machine_test/routes.dart';
import 'package:medipoint_machine_test/view/home_view.dart';
import 'package:medipoint_machine_test/view/register_view.dart';
import 'package:medipoint_machine_test/view/splash_view.dart';
import 'package:provider/provider.dart';

void main() {
   WidgetsFlutterBinding.ensureInitialized(); 
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (ctx)=> LoginProvider()),
       ChangeNotifierProvider(create: (ctx)=> DashboardProvider()),
        ChangeNotifierProvider(create: (ctx)=> RegisterProvider())
    ],
    child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return ConnectivityAppWrapper(
      app: MaterialApp(
        initialRoute: RegisterView.routeName,
        routes:routes ,
        debugShowCheckedModeBanner: false,
        title: 'MediPoint',
       theme: ThemeData(
        scaffoldBackgroundColor: AppColors.whiteColor
       ),
      ),
    );
  }
}
