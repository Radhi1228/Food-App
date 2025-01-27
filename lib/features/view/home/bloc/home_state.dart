/*class FoodState {}
class Category extends FoodState{
}*/
class HomeState {
  final List<String> categories;
  // final List<ProductModel> topPicks;
  // final List<ProductModel> allProducts;
  final String selectedCategory;
  List<String> imageList = [];
  List<String> nameList = [];

  HomeState({
    required this.categories,
    // required this.topPicks,
    // required this.allProducts,
    this.selectedCategory = '',
    required this.imageList,
    required this.nameList,
  });

  HomeState copyWith({
    required List<String> categories,
    // required List<ProductModel> topPicks,
    // required List<ProductModel> allProducts,
    required String selectedCategory,
    required List<String> imageList,
    required List<String> nameList,
  }) {
    return HomeState(
      // allProducts: allProducts,
      categories: [],
      imageList: imageList,
      nameList: nameList,
      //topPicks: topPicks,
      selectedCategory: selectedCategory,
    );
  }
}