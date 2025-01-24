import 'package:food_app/features/cart_bloc/cart_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedHelper {
  Future<void> setImageList(List<String> image) async {
    SharedPreferences shr = await SharedPreferences.getInstance();
    await shr.setStringList('image', image);
  }
  Future<void> setNameList(List<String> name) async {
    SharedPreferences shr = await SharedPreferences.getInstance();
    await shr.setStringList('name', name);
  }

  Future<List<String>> getNameList() async {
    SharedPreferences shr= await SharedPreferences.getInstance();
    List<String>name= shr.getStringList("name")??[];
    return name;
  }
  Future<List<String>> getImageList() async {
    SharedPreferences shr= await SharedPreferences.getInstance();
    List<String>image= shr.getStringList("image")??[];
    return image;
  }
  Future<List<ProductM>> getCartItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cartItemsJson = prefs.getStringList('cartItems') ?? [];
    List<ProductM> cartItems = cartItemsJson.map((item) => ProductM.fromJson(item)).toList();

    return cartItems;
  }

  Future<void> saveCartToStorage(List<ProductM> cartItems) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cartItemsJson = cartItems.map((item) => item.toJson()).toList();
    await prefs.setStringList('cartItems', cartItemsJson);
  }
}

// class Cart {
//   String name;
//   int price;
//
//
//   Cart({required this.name, required this.price});
//
//   factory Cart.mapToModel(Map m1) {
//     return Cart(
//       name: m1['name'],
//       price: m1['price'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'name': name,
//       'price': price,
//     };
//   }
//   Future<void> setCartList(List<Cart> cart) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<String> jsonStringList = cart.map((cart) => jsonEncode(cart.toJson())).toList();
//     await prefs.setStringList('cart', jsonStringList);
//     getCartList();
//   }
//   Future<List<Cart>> getCartList() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<String>? jsonStringList = prefs.getStringList('cart');
//     if (jsonStringList != null) {
//
//       print(jsonStringList.map((jsonString) => Cart.mapToModel(jsonDecode(jsonString))).toList()) ;
//     }
//     return [];
//   }
// }

