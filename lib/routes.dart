import 'package:flutter/material.dart';
import 'package:medipoint_machine_test/view/auth/login_view.dart';
import 'package:medipoint_machine_test/view/home_view.dart';
import 'package:medipoint_machine_test/view/register_view.dart';
import 'package:medipoint_machine_test/view/splash_view.dart';

Map<String, Widget Function(BuildContext)> routes = {
  SplashView.routeName:(ctx)=>SplashView(),
  LoginView.routeName:(ctx)=>LoginView(),
  HomeView.routeName:(ctx)=>HomeView(),
   RegisterView.routeName:(ctx)=>RegisterView(),
};
