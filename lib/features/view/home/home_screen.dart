import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/features/view/profile_screen.dart';
import '../../../utils/helper/auth_helper.dart';
import '../../bloc/food_bloc.dart';
import '../../bloc/food_event.dart';
import '../../bloc/food_state.dart';
import '../cart_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          title: const Text('Home'),
          leading: IconButton(
              onPressed: ()  {},
              icon: const Icon(Icons.menu)),
          actions: [
            IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: () {},
            ),
          ],
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return SingleChildScrollView(
              // scrollDirection : Axis.horizontal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //
                  // Search bar and carousel
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      //
                      decoration: InputDecoration(
                        hintText: 'Search your food',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  //
                  SizedBox(
                    height: 200,
                    child: PageView(
                      children: [
                        Image.asset('assets/image/c1.png'),
                        Image.asset('assets/image/c2.png'),
                      ],
                    ),
                  ),
                  // Categories
                  SizedBox(height: 20),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: state.categories.map(
                        (category) {
                          final isSelected = state.selectedCategory == category;
                          return GestureDetector(
                            onTap: () {
                              context
                                  .read<HomeBloc>()
                                  .add(SelectCategory(category));
                            },
                            //
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                color: isSelected ? Colors.green : Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              //
                              child: Text(
                                category,
                                style: TextStyle(
                                  color:
                                      isSelected ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                  //
                  // Top Picks
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Top Picks',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  // SizedBox(
                  //   height: 150,
                  //   child: ListView(
                  //     scrollDirection: Axis.horizontal,
                  //     children: state.topPicks.map((product) {
                  //       return Padding(
                  //         padding: const EdgeInsets.all(8.0),
                  //         child: Column(
                  //           children: [
                  //             Image.asset(product.imageUrl,
                  //                 repeat: ImageRepeat.repeat,
                  //                 width: 80,
                  //                 height: 80),
                  //             Text(product.name),
                  //             Text(product.price),
                  //           ],
                  //         ),
                  //       );
                  //     }).toList(),
                  //   ),
                  // ),
                  // All Products
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Discover',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  //const AlertDialog.adaptive(),
                  // GridView.builder(
                  //   shrinkWrap: true,
                  //   physics: const NeverScrollableScrollPhysics(),
                  //   itemCount: state.allProducts.length,
                  //   gridDelegate:
                  //       const SliverGridDelegateWithFixedCrossAxisCount(
                  //     crossAxisCount: 2,
                  //     mainAxisSpacing: 8,
                  //     crossAxisSpacing: 8,
                  //   ),
                  //   itemBuilder: (context, index) {
                  //     final product = state.allProducts[index];
                  //     return InkWell(
                  //       onTap: () {
                  //         Navigator.pushNamed(context, "/des",arguments: state.allProducts[index]);
                  //         // of(context).push(MaterialPageRoute(builder: (context) {
                  //         //   return FoodDescriptionScreen();
                  //         // },));
                  //       },
                  //       child: Container  (
                  //         decoration: BoxDecoration(
                  //           color: Colors.white,
                  //           borderRadius: BorderRadius.circular(10),
                  //         ),
                  //         child: Column(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           children: [
                  //             Image.asset(
                  //               product.imageUrl,
                  //               height: 135,
                  //               width: 135,
                  //               fit: BoxFit.cover,
                  //             ),
                  //             Text(
                  //               product.name,
                  //               style: const TextStyle(
                  //                   fontWeight: FontWeight.bold, fontSize: 16),
                  //             ),
                  //             Text(product.price),
                  //           ],
                  //         ),
                  //       ),
                  //     );
                  //   },
                  // ),
                ],
              ),
            );
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            if (index == 0) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const HomeScreen()));
            } else if (index == 1) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) =>  CartScreen(
                            // cartItems: [],
                          )));
            } else if (index == 2) {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => ProfileScreen()));
            }
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart), label: 'Cart'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}

// bottomNavigationBar: BottomNavigationBar(
//   items: [
//     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//     BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
//     BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
//   ],
// ),
