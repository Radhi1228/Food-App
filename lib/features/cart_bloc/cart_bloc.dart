import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/helper/shared_helper.dart';
import 'cart_event.dart';
import 'cart_state.dart';

// Product model
class Product {
  final String name;
  final String imageUrl;
  final String price;
   int quantity;

  Product({
    required this.name,
    required this.imageUrl,
    required this.price,
    this.quantity = 1,
  });

  Product copyWith({int? quantity}) {
    return Product(
      name: name,
      imageUrl: imageUrl,
      price: price,
      quantity: quantity ?? this.quantity,
    );
  }
}

// ---------- Cart Bloc ----------
class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState(imageList: [], nameList: [])) {
    on<AddItem>(_onAddItem);
    on<RemoveItem>(_onRemoveItem);
    on<ClearCart>(_onClearCart);
  }

  void _onAddItem(AddItem event, Emitter<CartState> emit) {
    final existingItem = state.cartItems.firstWhere(
      (item) => item.name == event.product.name,
      orElse: () => Product(name: '', imageUrl: '', price: '', quantity: 0),
    );

    List<Product> updatedCart;
    if (existingItem.quantity > 0) {
      updatedCart = state.cartItems.map((item) {
        if (item.name == event.product.name) {
          return item.copyWith(quantity: item.quantity + 1);
        }
        return item;
      }).toList();
    } else {
      updatedCart = [...state.cartItems, event.product];
    }

    _updateCartState(emit, updatedCart);
  }

  void addCardItem(product) {
    emit(state.copyWith(cartItems: [
      Product(
          name: product.name, imageUrl: product.imageUrl, price: product.price)
    ], imageList: [], nameList: []));
  }

  void _onRemoveItem(RemoveItem event, Emitter<CartState> emit) {
    final updatedCart = state.cartItems.where((item) {
      if (item.name == event.product.name) {
        return item.quantity > 1
            ? (item = item.copyWith(quantity: item.quantity - 1)) != null
            : false;
      }
      return true;
    }).toList();

    _updateCartState(emit, updatedCart);
  }

  void _onClearCart(ClearCart event, Emitter<CartState> emit) {
    emit(state.copyWith(cartItems: [], subtotal: '\$0.00', total: '\$0.00', imageList: [], nameList: []));
  }

  void _updateCartState(Emitter<CartState> emit, List<Product> updatedCart) {
    final subtotal = updatedCart.fold(
      0.0,
      (sum, item) =>
          sum +
          (double.tryParse(item.price.replaceAll('\$', '')) ?? 0) *
              item.quantity,
    );

    const discount = 0.1; // 10% discount
    const shipping = 25.0;

    final discountedAmount = subtotal * discount;
    final total = subtotal - discountedAmount + shipping;

    emit(
      state.copyWith(
        cartItems: updatedCart,
        subtotal: '\$${subtotal.toStringAsFixed(2)}',
        discount: '-\$${discountedAmount.toStringAsFixed(2)}',
        shipping: '\$${shipping.toStringAsFixed(2)}',
        total: '\$${total.toStringAsFixed(2)}', imageList: [], nameList: [],
      ),
    );
  }

  SharedHelper sharedHelper = SharedHelper();

  Future<void> setBookMark(String name1, String pImg) async {
    List<String> name = await sharedHelper.getNameList();
    List<String> img = await sharedHelper.getImageList();

    name.add(name1);
    img.add(pImg);

    sharedHelper.setNameList(name);
    sharedHelper.setImageList(img);
  }

  Future<void> removeBookMark(String name1, String pImg) async {
    List<String> name = await sharedHelper.getNameList();
    List<String> img = await sharedHelper.getImageList();

    name.remove(name1);
    img.remove(pImg);

    sharedHelper.setNameList(name);
    sharedHelper.setImageList(img);

    getBookMark();
  }

  Future<void> getBookMark() async {
    emit(state.copyWith(
        imageList: await sharedHelper.getImageList(),
        nameList: await sharedHelper.getNameList(),
    ));
  }
}
