import 'package:flutter/material.dart';
import 'package:food_app/features/view/cart_screen.dart';
import 'package:food_app/features/view/description_screen.dart';
import 'package:food_app/features/view/home/home_screen.dart';
import 'package:food_app/features/view/profile_screen.dart';
import 'package:food_app/features/view/sign_in_screen.dart';
import 'package:food_app/features/view/sign_up_screen.dart';
import 'package:food_app/features/view/splash_screen.dart';

import '../../features/view/description_screen.dart';

Map<String,WidgetBuilder> appRoutes =
{
  "/" : (c1) => const SplashScreen(),
  "/home" : (c1) => const HomeScreen(),
  "/signup" : (c1) => const SignUpScreen(),
  "/signin" : (c1) => const SignInScreen(),
  "/des" : (c1) =>  FoodDescriptionScreen(),
  "/cart" : (c1) =>  CartScreen(),
  "/profile" : (c1) =>  ProfileScreen(),
  //"/" : (c1) => HomeScreen(),
};