import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cart_bloc.dart';
import 'cart_state.dart';

class CartEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddItem extends CartEvent {
  final ProductM product;

  AddItem(this.product, {required Product});

  @override
  List<Object> get props => [product];
}

class RemoveItem extends CartEvent {
  final ProductM product;

  RemoveItem(this.product);

  @override
  List<Object> get props => [product];
}

class ClearCart extends CartEvent {}

class IncreaseQuantity extends CartEvent {
  final ProductM product;

  IncreaseQuantity({required this.product});
}

class DecreaseQuantity extends CartEvent {
  final ProductM product;

  DecreaseQuantity({required this.product});
}

class LoadCartItems extends CartEvent {}

class RemoveFromCart extends CartEvent {
  final ProductM product;
  RemoveFromCart({required this.product});
}