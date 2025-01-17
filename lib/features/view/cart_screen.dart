// import 'package:flutter/material.dart';
//
// class CartScreen extends StatefulWidget {
//   const CartScreen({super.key});
//
//   @override
//   State<CartScreen> createState() => _CartScreenState();
// }
//
// class _CartScreenState extends State<CartScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold();
//   }
// }
//********

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:food_app/features/cart_bloc/cart_bloc.dart';
//
// class CartScreen extends StatelessWidget {
//   const CartScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => CartBloc(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Cart'),
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//         ),
//         body: BlocBuilder<CartBloc, CartState>(
//           builder: (context, state) {
//             return Column(
//               children: [
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: state.cartItems.length,
//                     itemBuilder: (context, index) {
//                       final item = state.cartItems[index];
//                       return ListTile(
//                         leading: Image.asset(item.imageUrl, width: 50, height: 50),
//                         title: Text(item.name),
//                         subtitle: Text(item.price),
//                         trailing: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children:[
//                             //** IconButton(onPressed: () {}, icon: const Icon(Icons.import_contacts)),
//                             IconButton(
//                               icon: const Icon(Icons.remove),
//                               onPressed: () {
//                                 context.read<CartBloc>().add(RemoveItem(item));
//                               },
//                             ),
//                             Text(item.quantity.toString()),
//                             IconButton(
//                               icon: const Icon(Icons.add),
//                               onPressed: () {
//                                 context.read<CartBloc>().add(AddItem(item));
//                               },
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Divider(),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text('Subtotal:'),
//                           Text(state.subtotal),
//                         ],
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text('Discount:'),
//                           Text(state.discount),
//                         ],
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text('Shipping:'),
//                           Text(state.shipping),
//                         ],
//                       ),
//                       const Divider(),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text('Total:'),
//                           Text(state.total),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

/*--------------*/
// import 'package:flutter/material.dart';
//
// class CartScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final cartItems = [
//       {
//         "name": "Pasta",
//         "price": 13.99,
//         "quantity": 2,
//         "imageUrl": "assets/image/broccoli.png",
//       },
//       {
//         "name": "Broccoli",
//         "price": 6.99,
//         "quantity": 1,
//         "imageUrl": "assets/image/broccoli.png",
//       },
//     ];
//
//     double calculateTotal() {
//       return cartItems.fold(
//         0,
//             (total, item) =>
//         total + (item["price"] as double) * (item["quantity"] as int),
//       );
//     }
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Cart"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Expanded(
//               child: ListView.builder(
//                 itemCount: cartItems.length,
//                 itemBuilder: (context, index) {
//                   final item = cartItems[index];
//                   return Card(
//                     child: ListTile(
//                       leading: Image.asset(
//                         item["imageUrl"] as String,
//                         width: 60,
//                         height: 60,
//                         fit: BoxFit.cover,
//                       ),
//                       title: Text(item["name"] as String),
//                       subtitle: Text(
//                           "\$${item["price"]} x ${item["quantity"]} = \$${(item["price"] as double) * (item["quantity"] as int)}"),
//                       trailing: IconButton(
//                         icon: const Icon(Icons.remove_circle),
//                         onPressed: () {
//                           // Remove item logic
//                         },
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             const Divider(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   "Total",
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text(
//                   "\$${calculateTotal()}",
//                   style: const TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 // Checkout logic
//               },
//               child: const Text("Checkout"),
//               style: ElevatedButton.styleFrom(
//                 minimumSize: const Size(double.infinity, 50),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/features/bloc/food_bloc.dart';
import 'package:food_app/features/cart_bloc/cart_bloc.dart';
import 'package:food_app/features/cart_bloc/cart_state.dart';

import '../bloc/food_state.dart';

class CartScreen extends StatefulWidget {
  // final List<Product>? cartItems;

  const CartScreen({super.key,
    // this.cartItems
  });

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    context.read<HomeBloc>().getBookMark();
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
            builder: (context, state1) {
              return  Padding(
                padding: const EdgeInsets.all(16.0),
                child: state.nameList.isEmpty
                    ? const Center(
                  child: Text(
                    "Your cart is empty!",
                    style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                )
                    : Column(
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
                            child: ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  item.imageUrl,
                                  //item.imageUrl,
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: Text(item.name),
                              subtitle:Text(
                                //"Food",
                                "\$${item.price} x ${item.quantity}",
                                style: const TextStyle(fontSize: 14),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove_circle),
                                    onPressed: () {
                                      setState(() {
                                        // state.nameList.removeAt(index);
                                        // state.imageList.removeAt(index);
                                        if ((item.quantity ?? 0) > 1) {
                                          (item.quantity ?? 0) - 1;
                                        } else {
                                          state1.cartItems.removeAt(index);
                                          //state.nameList.removeAt(index);
                                        }
                                      });
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add_circle),
                                    onPressed: () {
                                      setState(() {
                                         (item.quantity ?? 0) + 1;
                                        //print('${item.quantity}');
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    // const Divider(),
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: TextField(
                    //         decoration: InputDecoration(
                    //           labelText: "Promo Code",
                    //           border: OutlineInputBorder(
                    //             borderRadius: BorderRadius.circular(10),
                    //           ),
                    //           contentPadding: const EdgeInsets.symmetric(
                    //               horizontal: 10, vertical: 10),
                    //         ),
                    //       ),
                    //     ),
                    //     const SizedBox(width: 10),
                    //     ElevatedButton(
                    //       onPressed: () {
                    //         // Apply promo code logic
                    //       },
                    //       style: ElevatedButton.styleFrom(
                    //         padding: const EdgeInsets.symmetric(
                    //             horizontal: 20, vertical: 15),
                    //       ),
                    //       child: const Text("Apply"),
                    //     ),
                    //   ],
                    // ),
                    // const SizedBox(height: 16),
                    // Column(
                    //   children: [
                    //     // _buildSummaryRow("Subtotal", "\$${widget.calculateTotal()}"),
                    //     _buildSummaryRow("Discount", "-\$25.00"),
                    //     _buildSummaryRow("Shipping", "\$10.00"),
                    //     const Divider(),
                    //     // _buildSummaryRow(
                    //     //   "Total",
                    //     //   "\$${(calculateTotal() - 25 + 10).toStringAsFixed(2)}",
                    //     // ),
                    //   ],
                    // ),
                    // const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: Colors.green,
                      ),
                      child: const Text("Done"),
                    ), 
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
  // Widget _buildSummaryRow(String title, String value) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 4),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Text(
  //           title,
  //           style: const TextStyle(fontSize: 16),
  //         ),
  //         Text(
  //           value,
  //           style: const TextStyle(
  //             fontSize: 16,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
