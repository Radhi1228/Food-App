import 'package:flutter/material.dart';
import 'package:food_app/features/view/cart/cart_screen.dart';
import 'package:food_app/features/view/home/home_screen.dart';
import 'package:food_app/features/view/profile/profile_screen.dart';
import 'package:food_app/features/view/login/sign_in_screen.dart';
import 'package:food_app/features/view/login/sign_up_screen.dart';
import 'package:food_app/features/view/splash_screen.dart';

Map<String,WidgetBuilder> appRoutes =
{
  "/" : (c1) => const SplashScreen(),
  "/home" : (c1) => const HomeScreen(),
  "/signup" : (c1) => const SignUpScreen(),
  "/signin" : (c1) => const SignInScreen(),
 // "/des" : (c1) =>  ProductDescriptionScreen(),
  "/cart" : (c1) =>  CartScreen(),
  "/profile" : (c1) =>  ProfileScreen(),
  //"/" : (c1) => HomeScreen(),
};