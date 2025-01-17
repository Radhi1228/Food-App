// class FoodEvent {}
// class Category extends FoodEvent{
//
// }
//********
import '../../utils/model/app_models.dart';

abstract class HomeEvent {}

class LoadHomeData extends HomeEvent {}

class SelectCategory extends HomeEvent {
  final String category;

  SelectCategory(this.category);
}

