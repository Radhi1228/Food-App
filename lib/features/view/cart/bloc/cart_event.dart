class CartItemEvent {}

class LoadCart extends CartItemEvent {
  final String userId;
  LoadCart(this.userId);
}

class RemoveCartItem extends CartItemEvent {
  final String cartItemId;
  RemoveCartItem(this.cartItemId);
}

class UpdateCartQuantity extends CartItemEvent {
  final String cartItemId;
  final int newQuantity;
  UpdateCartQuantity(this.cartItemId, this.newQuantity);
}
