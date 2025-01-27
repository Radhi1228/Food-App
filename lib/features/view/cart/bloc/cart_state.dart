class CartItemState {}

class CartInitial extends CartItemState {}

class CartLoading extends CartItemState {}

class CartLoaded extends CartItemState {
  final List<Map<String, dynamic>> cartItems;
  CartLoaded(this.cartItems);
}

class CartError extends CartItemState {
  final String error;
  CartError(this.error);
}