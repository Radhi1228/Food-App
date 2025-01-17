class ProductModel {
  final String name;
  final String description;
  final String price;
  final String imageUrl;
  final int calories;
  final int rating;
  final int deliveryTime;

  ProductModel({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.calories,
    required this.rating,
    required this.deliveryTime,
  });
}

class CartModel {
  final ProductModel product;
  final int quantity;

  CartModel({required this.product, required this.quantity});
}

class UserProfile {
  final String name;
  final String email;
  final String profileImage;

  UserProfile({
    required this.name,
    required this.email,
    required this.profileImage,
  });
}
