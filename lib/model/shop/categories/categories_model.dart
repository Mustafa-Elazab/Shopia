class CategoriesModel{
  bool status;
  String message;

  CategoriesDataModel data;

  CategoriesModel.FromJson(Map<String , dynamic> json){

    status=json['status'];
    message=json['message'];

    data=CategoriesDataModel.FromJson(json['data']);
  }
}

class CategoriesDataModel{

  int current_page;
  List<DataModel> data=[];

  CategoriesDataModel.FromJson(Map<String , dynamic> json){

    current_page=json['current_page'];

    json['data'].forEach((element)
    {
      data.add(DataModel.FromJson(element));
    });

  }
}
class DataModel{
  int id;
  String name;
  String image;

  DataModel.FromJson(Map <String , dynamic> json){

    id=json['id'];
    name=json['name'];
    image=json['image'];
  }
}