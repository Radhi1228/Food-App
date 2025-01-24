import 'package:flutter/material.dart';
import 'package:food_app/features/cart_bloc/cart_bloc.dart';
import 'package:food_app/features/cart_bloc/cart_event.dart';
import 'package:food_app/features/cart_bloc/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/features/bloc/food_bloc.dart';

import '../bloc/food_state.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({
    super.key,
    // this.cartItems
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
              IconButton(onPressed: () {}, icon: const Icon(Icons.add_road)),
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
          body: BlocBuilder<CartBloc, CartState>(
            buildWhen: (previous, current) {
              print('previous.cartItems != current.cartItems=>${previous.cartItems != current.cartItems}');
              return previous.cartItems != current.cartItems;
            },
            builder: (context, state1) {
              if (state1.cartItems.isEmpty) {
                return const Center(child: Text("Empty Cart! Add something"));
              }
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: state1.cartItems.length,
                      itemBuilder: (context, index) {
                        final item = state1.cartItems[index];
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: InkWell(
                            onTap: () {
                              context.read<CartBloc>().onClearCart;
                            },
                            child: ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  item.imageUrl,
                                  //item.imageUrl,
                                  //item.imageUrl,
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: Text(item.name),
                              subtitle: Text(
                                "\$${item.price} x ${item.quantity}",
                                style: const TextStyle(fontSize: 14),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove_circle),
                                    onPressed: () {
                                      if (item.quantity > 1) {
                                        context
                                            .read<CartBloc>()
                                            .addRemoveQuantity(index, false);
                                      } else {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: const Text("Remove Item"),
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
                                                    context.read<CartBloc>().onRemoveFromCart(index);
                                                    Future.delayed(const Duration(milliseconds: 100), () {
                                                      Navigator.pop(context);
                                                    });
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
                                    item.quantity.toString(),
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add_circle),
                                    onPressed: () {
                                      context
                                          .read<CartBloc>()
                                          .addRemoveQuantity(index, true);
                                      print('item quantity=>${item.quantity}');
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 20, right: 10, left: 10),
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
            },
          ),
        );
      },
    );
  }

  Widget showDialogue(int index) {
    return AlertDialog(
      title: const Text('Remove this product from cart'),
      content: const SingleChildScrollView(
        child: ListBody(
          children: [
            Text('Are you sure want to delete this product '),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('no'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('yes'),
          onPressed: () {
            context.read<CartBloc>().addRemoveQuantity(index, false);
          },
        ),
      ],
    );
  }
}
