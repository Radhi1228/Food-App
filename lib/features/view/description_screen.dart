import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/food_bloc.dart';
import '../bloc/food_state.dart';
import '../cart_bloc/cart_bloc.dart';

//
// class DescriptionScreen extends StatefulWidget {
//   const DescriptionScreen({super.key});
//
//   @override
//   State<DescriptionScreen> createState() => _DescriptionScreenState();
// }
// class _DescriptionScreenState extends State<DescriptionScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold();
//   }
// }

class FoodDescriptionScreen extends StatefulWidget {
  @override
  State<FoodDescriptionScreen> createState() => _FoodDescriptionScreenState();
}

class _FoodDescriptionScreenState extends State<FoodDescriptionScreen> {
  @override
  void initState() {
    super.initState();
  }
  // final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        CartBloc cubit = context.read<CartBloc>();
        dynamic product = ModalRoute.of(context)?.settings.arguments;
        //print('product=>$product');
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(product.name),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    product.imageUrl,
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(product.description),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.price,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.read<CartBloc>().setBookMark(product.name,product.imageUrl);
                        //context.read<HomeProvider>().setBookMark(p1!.name!, p1!.image!);
                        print("------------${product}");
                        cubit.addCardItem(product);
                        print('cubit value=>${cubit.state.cartItems.length}');
                        print('cubit value=>${cubit.state.cartItems}');
                        Navigator.pushNamed(context, "/cart");
                        //Navigator.pushNamed(context, "/cart");
                        // Navigator.push(context,"");
                      },
                      child: const Text("Add to Cart"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}