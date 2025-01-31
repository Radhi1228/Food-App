import 'package:equatable/equatable.dart';
import 'cart_bloc.dart';

class CartState extends Equatable {
  final List<ProductM> cartItems;
  final String subtotal;
  final String discount;
  final String shipping;
  final String total;
  List<String> imageList = [];
  List<String> nameList = [];

   CartState({
    this.cartItems = const [],
    this.subtotal = '\$0.00',
    this.discount = '\$0.00',
    this.shipping = '\$0.00',
    this.total = '\$0.00',
    required this.imageList,
    required this.nameList,
  });

  CartState copyWith({
    List<ProductM>? cartItems,
    String? subtotal,
    String? discount,
    String? shipping,
    String? total,
     List<String>? imageList,
     List<String>? nameList,
  }) {
    return CartState(
      cartItems: cartItems ?? this.cartItems,
      subtotal: subtotal ?? this.subtotal,
      discount: discount ?? this.discount,
      shipping: shipping ?? this.shipping,
      total: total ?? this.total,
      imageList: imageList??this.imageList,
      nameList: nameList??this.nameList,
    );
  }

  @override
  List<Object> get props => [cartItems, subtotal, discount, shipping, total];
}