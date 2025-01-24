import 'dart:convert';

// class ProductModel {
//   final String name;
//   final String description;
//   final String price;
//   final String imageUrl;
//   final int calories;
//   final int rating;
//   final int deliveryTime;
//   final int quantity;
//
//   ProductModel({
//     this.quantity=1,
//     required this.name,
//     required this.description,
//     required this.price,
//     required this.imageUrl,
//     this.calories = 1,
//     this.rating = 1,
//     this.deliveryTime = 1 ,
//   });
// }

class CartModel {
  //final ProductModel product;
  final int quantity;

  CartModel({
    //required this.product,
    required this.quantity});
}

class ProfileModel {
  String? name, mobile, email, uid;

  ProfileModel({this.name, this.mobile, this.email,this.uid});

  factory ProfileModel.mapToModel(Map m1) {
    return ProfileModel(
        mobile: m1['mobile'],
        email: m1['email'],
        name: m1['name'],
        uid: m1['uid']
    );
  }
}

class CartItem {
  final String name;
  final String imageUrl;
  final String price;
  int quantity;

  CartItem({required this.name, required this.imageUrl,required this.price, required this.quantity});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'price': price,
      'quantity' : quantity
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      name: map['name'],
      imageUrl: map['imageUrl'],
      price: map['price'] ?? "",
      quantity: map['quantity'],
    );
  }
  String toJson() => json.encode(toMap());
  factory CartItem.fromJson(String source) {
    return CartItem.fromMap(json.decode(source));
  }
}