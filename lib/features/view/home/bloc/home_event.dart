class HomeEvent {}

class LoadHomeData extends HomeEvent {}

class SelectCategory extends HomeEvent {
  final String category;

  SelectCategory(this.category);
}

