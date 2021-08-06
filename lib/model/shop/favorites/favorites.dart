class FavoritesModel{

  bool status;
  String message;

  FavoritesModel.fromJson(Map<String,dynamic> json){
    status=json['status'];
    message=json['message'];
  }

}

class FavoritesDataModel{
   int id;

   ProductModel product;

   FavoritesDataModel.fromJson(Map<String,dynamic> json){
     id=json['id'];
     product=ProductModel.fromJson(json['product']);
   }

}

class ProductModel{

  int id;
  dynamic price;
  dynamic old_price;
  dynamic discount;
  String image;

  ProductModel.fromJson(Map<String , dynamic> json){
    id=json['id'];
    price=json['price'];
    old_price=json['old_price'];
    discount=json['discount'];
    image=json['image'];
  }
}