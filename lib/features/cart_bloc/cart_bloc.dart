import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/helper/shared_helper.dart';
import 'cart_event.dart';
import 'cart_state.dart';

//Product model

class ProductM {
  final String name;
  final String imageUrl;
  final String price;
  int quantity;

  ProductM({
    required this.name,
    required this.imageUrl,
    required this.price,
    this.quantity = 1,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'price': price,
      'quantity': quantity,
    };
  }

  factory ProductM.fromMap(Map<String, dynamic> map) {
    return ProductM(
      name: map['name'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      price: map['price'] ?? '',
      quantity: map['quantity'] ?? 1,
    );
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory ProductM.fromJson(String source) {
    return ProductM.fromMap(json.decode(source));
  }

  ProductM copyWith({int? quantity}) {
    return ProductM(
      name: name,
      imageUrl: imageUrl,
      price: price,
      quantity: quantity ?? this.quantity,
    );
  }
}

// ---------- Cart Bloc ----------
class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState(imageList: const [], nameList: const [])) {
    on<AddItem>(onAddQuantity);
    on<RemoveItem>(onRemoveItem);
    on<ClearCart>(onClearCart);
    on<LoadCartItems>(onLoadCartItems);
  }

  void onAddQuantity(AddItem event, Emitter<CartState> emit) {
    final existingItem = state.cartItems.firstWhere(
      (item) => item.name == event.product.name,
      orElse: () => ProductM(name: '', imageUrl: '', price: '', quantity: 0),
    );

    List<ProductM> updatedCart;
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

    updateCartState(emit, updatedCart);
  }

  addRemoveQuantity(int index, bool isAdd) async {
    List<ProductM> updatedCart = List.from(state.cartItems);

    if (index >= 0 && index < updatedCart.length) {
      ProductM updatedProduct = updatedCart[index].copyWith(
          quantity: isAdd
              ? updatedCart[index].quantity + 1
              : updatedCart[index].quantity - 1);
      updatedCart[index] = updatedProduct;
    }
    await sharedHelper.saveCartToStorage(updatedCart);
    emit(state.copyWith(cartItems: updatedCart));
  }

  void onLoadCart(LoadCartItems event, Emitter<CartState> emit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cartItemsJson = prefs.getStringList('cartItems') ?? [];
    List<ProductM> cartItems =
        cartItemsJson.map((item) => ProductM.fromJson(item)).toList();

    emit(state.copyWith(cartItems: cartItems));
  }

  void addCardItem(product) {
    emit(state.copyWith(cartItems: [
      ProductM(
          name: product.name,
          imageUrl: product.imageUrl,
          price: product.price,
          quantity: product.quantity)
    ], imageList: [], nameList: []));
  }

  void onRemoveFromCart(int index) {
    final updatedCart = List<ProductM>.from(state.cartItems)..removeAt(index);
    emit(state.copyWith(cartItems: updatedCart));
  }


  void onRemoveItem(RemoveItem event, Emitter<CartState> emit) {
    final updatedCart = state.cartItems.where((item) {
      if (item.name == event.product.name) {
        return item.quantity > 1
            ? (item = item.copyWith(quantity: item.quantity - 1)) != null
            : false;
      }
      return true;
    }).toList();

    updateCartState(emit, updatedCart);
  }

  void onClearCart(ClearCart event, Emitter<CartState> emit) {
    emit(state.copyWith(
        cartItems: [],
        subtotal: '\$0.00',
        total: '\$0.00',
        imageList: [],
        nameList: []));
  }

  void updateCartState(Emitter<CartState> emit, List<ProductM> updatedCart) {
    final subtotal = updatedCart.fold(
      0.0,
      (sum, item) =>
          sum +
          (double.tryParse(item.price.replaceAll('\$', '')) ?? 0) *
              item.quantity,
    );

    const discount = 0.1;
    const shipping = 25.0;

    final discountedAmount = subtotal * discount;
    final total = subtotal - discountedAmount + shipping;

    emit(
      state.copyWith(
        cartItems: updatedCart,
        subtotal: '\$${subtotal.toStringAsFixed(2)}',
        discount: '-\$${discountedAmount.toStringAsFixed(2)}',
        shipping: '\$${shipping.toStringAsFixed(2)}',
        total: '\$${total.toStringAsFixed(2)}',
        imageList: [],
        nameList: [],
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

  void onLoadCartItems(LoadCartItems event, Emitter<CartState> emit) async {
    try {
      List<ProductM> cartItems = await sharedHelper.getCartItems();
      emit(state.copyWith(cartItems: cartItems));
    } catch (e) {
      print("Cart items: $e");
    }
  }
}
