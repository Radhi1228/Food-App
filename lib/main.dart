import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/features/cart_bloc/cart_bloc.dart';
import 'package:food_app/features/view/cart/bloc/cart_bloc.dart';
import 'package:food_app/utils/helper/firedb_helper.dart';
import 'package:food_app/utils/routes/app_routes.dart';
import 'features/view/home/bloc/home_bloc.dart';
import 'features/view/home/bloc/home_state.dart';
import 'firebase_options.dart';

Future<void> main()
async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
  FoodApp());
  // MaterialApp(
  //   debugShowCheckedModeBanner: false,
  //   routes: appRoutes,
  //   theme: ThemeData(
  //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
  //   ),
  // ));
}
class FoodApp extends StatefulWidget {
  const FoodApp({super.key});

  @override
  State<FoodApp> createState() => _FoodAppState();
}

class _FoodAppState extends State<FoodApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
     providers: [
       BlocProvider<HomeBloc>(
         create: (BuildContext context) => HomeBloc(),
       ),
       BlocProvider<CartBloc>(
         create: (BuildContext context) => CartBloc(),
       ),
       BlocProvider<CartItemBloc>(
         create: (BuildContext context) => CartItemBloc(FireDbHelper.helper),
       ),
     ],
      child: BlocBuilder<HomeBloc,HomeState>
        (builder:(context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            routes: appRoutes,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
            ),
          );
        }, ),
    );
  }
}
/*
* bottomNavigationBar: BottomNavigationBar(
  onTap: (index) {
    if (index == 0) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
    } else if (index == 1) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => CartScreen()));
    } else if (index == 2) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => ProfileScreen()));
    }
  },
  items: [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
  ],
),

* */