import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../utils/helper/firedb_helper.dart';

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

class ProductDescriptionScreen extends StatelessWidget {
  final QueryDocumentSnapshot product;

  const ProductDescriptionScreen({super.key, required this.product, required String productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product['name']),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            product['imageUrl'],
            height: 250,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              product['name'],
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              '\$${product['price']}',
              style: const TextStyle(fontSize: 20, color: Colors.green),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () async {
                await FireDbHelper.helper.addToCart('userId', 'productId', 1);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Product added to cart!")),
                );
              },
              child: const Text('Add to Cart'),
            ),
          )
          // Padding(
          //   padding: const EdgeInsets.all(16.0),
          //   child: ElevatedButton(
          //     onPressed: () {},
          //     child: const Text('Add to Cart'),
          //   ),
          // )
          /**/
          // Padding(
          //   padding: const EdgeInsets.all(16.0),
          //   child: ElevatedButton(
          //     onPressed: () async {
          //       final userId = FirebaseAuth.instance.currentUser?.uid;
          //       if (userId == null) {
          //         // If the user is not logged in, redirect to the sign-in screen
          //         Navigator.pushNamed(context, '/signin');
          //         return;
          //       }
          //       try {
          //         final cartCollection = FirebaseFirestore.instance.collection('cart');
          //         final cartQuery = await cartCollection
          //             .where('userId', isEqualTo: userId)
          //             .where('productId', isEqualTo: product['id'])
          //             .get();
          //         if (cartQuery.docs.isNotEmpty) {
          //
          //           final docId = cartQuery.docs.first.id;
          //           final existingQuantity = cartQuery.docs.first['quantity'];
          //
          //           await cartCollection.doc(docId).update({
          //             'quantity': existingQuantity + 1,
          //           });
          //         } else {
          //
          //           await cartCollection.add({
          //             'userId': userId,
          //             'productId': product['id'],
          //             'name': product['name'],
          //             'imageUrl': product['imageUrl'],
          //             'quantity': 1,
          //             'price': product['price'],
          //           });
          //         }
          //         // Show confirmation
          //         ScaffoldMessenger.of(context).showSnackBar(
          //           const SnackBar(content: Text('Product added to cart!')),
          //         );
          //       } catch (e) {
          //
          //         ScaffoldMessenger.of(context).showSnackBar(
          //           SnackBar(content: Text('Failed to add to cart: $e')),
          //         );
          //       }
          //     },
          //     style: ElevatedButton.styleFrom(
          //       minimumSize: const Size(double.infinity, 50),
          //       backgroundColor: Colors.green,
          //     ),
          //     child: const Text('Add to Cart'),
          //   ),
          // )
        ],
      ),
    );
  }
}