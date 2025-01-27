import 'package:bloc/bloc.dart';
import 'package:food_app/utils/helper/firedb_helper.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartItemBloc extends Bloc<CartItemEvent, CartItemState> {
  final FireDbHelper fireDbHelper;

  CartItemBloc(this.fireDbHelper) : super(CartInitial()) {
    on<LoadCart>((event, emit) async {
      emit(CartLoading());
      try {
        final cartItems = await fireDbHelper.fetchCartItems(event.userId);
        emit(CartLoaded(cartItems.cast<Map<String, dynamic>>()));
      } catch (e) {
        emit(CartError(e.toString()));
      }
    });
    on<RemoveCartItem>((event, emit) async {
      emit(CartLoading());
      try {
        await fireDbHelper.removeFromCart(event.cartItemId);
        // Reload the cart after removal
        add(LoadCart(event.cartItemId));
      } catch (e) {
        emit(CartError(e.toString()));
      }
    });
    on<UpdateCartQuantity>((event, emit) async {
      emit(CartLoading());
      try {
        await fireDbHelper.updateCartQuantity(event.cartItemId, event.newQuantity);
        // Reload the cart after updating the quantity
        add(LoadCart(event.cartItemId));
      } catch (e) {
        emit(CartError(e.toString()));
      }
    });
  }
}
