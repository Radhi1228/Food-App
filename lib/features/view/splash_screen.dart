import 'package:flutter/material.dart';
import '../../utils/helper/auth_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    bool logIN = AuthHelper.helper.checkUser();
    Future.delayed(
      const Duration(seconds: 4),
      () {
        Navigator.pushNamed(context, logIN ? "/home" : '/signin');
        // Navigator.pushAndRemoveUntil(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => const SignInScreen(),
        //     ),
        //     (_) => false);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset("assets/image/food.jpg"),
      ),
    );
  }
}
