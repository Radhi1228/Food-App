import 'package:equatable/equatable.dart';

import 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddItem extends CartEvent {
  final Product product;

  AddItem(this.product);

  @override
  List<Object> get props => [product];
}

class RemoveItem extends CartEvent {
  final Product product;

  RemoveItem(this.product);

  @override
  List<Object> get props => [product];
}

class ClearCart extends CartEvent {}
//final CartItem item;
//
//   AddToCartEvent(this.item);
//