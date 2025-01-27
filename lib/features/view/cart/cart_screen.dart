import 'package:flutter/material.dart';
import 'package:food_app/features/cart_bloc/cart_bloc.dart';
import 'package:food_app/features/cart_bloc/cart_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/utils/helper/firedb_helper.dart';
import '../home/bloc/home_bloc.dart';
import '../home/bloc/home_state.dart';
import 'bloc/cart_bloc.dart';
import 'bloc/cart_event.dart';
import 'bloc/cart_state.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({
    super.key,
  });

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    context.read<HomeBloc>().getBookMark();
    context.read<CartBloc>().add(LoadCartItems());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add_road),
                ),
              ],
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: const Text("Cart"),
              centerTitle: true,
              backgroundColor: Colors.white,
              elevation: 0,
              foregroundColor: Colors.black,
            ),
            body: BlocBuilder<CartItemBloc,CartItemState>(
              builder: (context, cartState) {
                if (cartState is CartLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (cartState is CartLoaded) {
                  if (cartState.cartItems.isEmpty) {
                    return const Center(
                        child: Text("Empty Cart!"));
                  }
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: cartState.cartItems.length,
                          itemBuilder: (context, index) {
                            final item = cartState.cartItems[index];
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 2,
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              child: ListTile(
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    item['imageUrl'],
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                title: Text(item['name']),
                                subtitle: Text(
                                  "\$${item['price']} x ${item['quantity']}",
                                  style: const TextStyle(fontSize: 14),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.remove_circle),
                                      onPressed: () {
                                        if (item['quantity'] > 1) {
                                          context.read<CartItemBloc>().add(
                                              UpdateCartQuantity(item['id'],
                                                  item['quantity'] - 1));
                                        } else {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: const Text(
                                                    "Remove Item"),
                                                content: const Text(
                                                    "Do you want to remove this item from the cart?"),
                                                actions: [
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text("No"),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      FireDbHelper.helper.removeFromCart(item['id']);
                                                      // context.read<CartItemBloc>()
                                                      //     .add(
                                                      //     RemoveFromCart(
                                                      //         item['id']));
                                                      // Navigator.pop(context);
                                                    },
                                                    child: const Text("Yes"),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        }
                                      },
                                    ),
                                    Text(
                                      item['quantity'].toString(),
                                      style: const TextStyle(
                                          color: Colors.black),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.add_circle),
                                      onPressed: () {
                                        context.read<CartItemBloc>().add(
                                            UpdateCartQuantity(
                                                item['id'],
                                                item['quantity'] + 1));
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 20, right: 10, left: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50),
                            backgroundColor: Colors.green,
                          ),
                          child: const Text("Done"),
                        ),
                      ),
                    ],
                  );
                } else if (cartState is CartError) {
                  return Center(child: Text("Error: ${cartState.error}"));
                } else {
                  return const Center(child: Text("No items in the cart"));
                }
              },
            ),
          );
        }
    );
  }
}
// Widget showDialogue(int index) {
//   return AlertDialog(
//     title: const Text('Remove this product from cart'),
//     content: const SingleChildScrollView(
//       child: ListBody(
//         children: [
//           Text('Are you sure want to delete this product '),
//         ],
//       ),
//     ),
//     actions: <Widget>[
//       TextButton(
//         child: const Text('no'),
//         onPressed: () {
//           Navigator.of(context).pop();
//         },
//       ),
//       TextButton(
//         child: const Text('yes'),
//         onPressed: () {
//           context.read<CartBloc>().addRemoveQuantity(index, false);
//         },
//       ),
//     ],
//   );
// }
