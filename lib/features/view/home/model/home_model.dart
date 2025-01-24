class ProductModel {
   String? pName;
   String description;
   String price;
   String imageUrl;
   int quantity;

  ProductModel({
    this.quantity=1,
    required this.pName,
    required this.description,
    required this.price,
    required this.imageUrl,
  });
  factory ProductModel.mapTOModel(Map m1) {
    return ProductModel(pName:m1['pName'], description: m1['description'], price: m1['price'], imageUrl: m1['imageUrl']);
  }
}