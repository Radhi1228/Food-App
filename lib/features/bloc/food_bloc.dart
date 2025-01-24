import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/helper/shared_helper.dart';
import '../../utils/model/app_models.dart';
import 'food_event.dart';
import 'food_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc()
      : super(HomeState(
          categories: ['Fruits', 'Veggie', 'Bread', 'Burger', 'Strawberry'],
          // topPicks: [
          //   ProductModel(
          //       name: 'Banana',
          //       price: '\$2.39',
          //       imageUrl: 'assets/image/banana.png',
          //       description:
          //           'Food can be described by its taste, texture, and other characteristics\nTaste: Food can be sweet, savory, spicy, bitter, acidic, or full-bodied.'),
          //   ProductModel(
          //       name: 'Broccoli',
          //       price: '\$10.39',
          //       imageUrl: 'assets/image/broccoli.png',
          //       description:
          //           'Food can be described by its taste, texture, and other characteristics\nTaste: Food can be sweet, savory, spicy, bitter, acidic, or full-bodied.'),
          //   ProductModel(
          //       name: 'Strawberry',
          //       price: '\$12.20',
          //       imageUrl: 'assets/image/strawberry.png',
          //       description:
          //           'Food can be described by its taste, texture, and other characteristics\nTaste: Food can be sweet, savory, spicy, bitter, acidic, or full-bodied.'),
          // ],
          // allProducts: [
          //   ProductModel(
          //       name: 'Almond',
          //       price: '\$8.99',
          //       imageUrl: 'assets/image/almond.png',
          //       description:
          //           'Food can be described by its taste, texture, and other characteristics\nTaste: Food can be sweet, savory, spicy, bitter, acidic, or full-bodied.'),
          //   ProductModel(
          //       name: 'Pasta',
          //       price: '\$13.99',
          //       imageUrl: 'assets/image/pasta.png',
          //       description:
          //           'Food can be described by its taste, texture, and other characteristics\nTaste: Food can be sweet, savory, spicy, bitter, acidic, or full-bodied.'),
          //   ProductModel(
          //       name: 'Mushrooms',
          //       price: '\$8.99',
          //       imageUrl: 'assets/image/mushroom.png',
          //       description:
          //           'Food can be described by its taste, texture, and other characteristics\nTaste: Food can be sweet, savory, spicy, bitter, acidic, or full-bodied.'),
          //   ProductModel(
          //       name: 'Lettuce',
          //       price: '\$13.99',
          //       imageUrl: 'assets/image/lettuce.png',
          //       description:
          //           'Food can be described by its taste, texture, and other characteristics\nTaste: Food can be sweet, savory, spicy, bitter, acidic, or full-bodied.'),
          //   ProductModel(
          //       name: 'Kiwi',
          //       price: '\$6.99',
          //       imageUrl: 'assets/image/kiwi.png',
          //       description:
          //           'Food can be described by its taste, texture, and other characteristics\nTaste: Food can be sweet, savory, spicy, bitter, acidic, or full-bodied.'),
          //   ProductModel(
          //       name: 'Cabbage',
          //       price: '\$6.99',
          //       imageUrl: 'assets/image/cabbage.png',
          //       description:
          //           'Food can be described by its taste, texture, and other characteristics\nTaste: Food can be sweet, savory, spicy, bitter, acidic, or full-bodied.',),
          //   ProductModel(
          //       name: 'Tomatoes',
          //       price: '\$8.99',
          //       imageUrl: 'assets/image/tomato.png',
          //       description:
          //           'Food can be described by its taste, texture, and other characteristics\nTaste: Food can be sweet, savory, spicy, bitter, acidic, or full-bodied.'),
          //   ProductModel(
          //       name: 'Capsicum',
          //       price: '\$13.99',
          //       imageUrl: 'assets/image/capsicum.png',
          //       description:
          //           'Food can be described by its taste, texture, and other characteristics\nTaste: Food can be sweet, savory, spicy, bitter, acidic, or full-bodied.'),
          // ],
          imageList: [],
          nameList: [],
        )) {
    on<LoadHomeData>((event, emit) {
      // Optionally load data
    });

    on<SelectCategory>((event, emit) {
      emit(HomeState(
        categories: state.categories,
        //topPicks: state.topPicks,
        //allProducts: state.allProducts,
        selectedCategory: event.category,
        imageList: [],
        nameList: [],
      ));
    });
  }

  Future<void> getBookMark() async {
    emit(state.copyWith(
        categories: [],
        // topPicks: [],
        // allProducts: [],
        imageList: await sharedHelper.getImageList(),
        nameList: await sharedHelper.getNameList(),
        selectedCategory: ''));
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
}
