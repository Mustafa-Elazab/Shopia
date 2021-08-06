class SettingModel {
  bool status;
  String message;
  SettingDataModel data;


  SettingModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new SettingDataModel.fromJson(json['data']) : null;
  }


}

class SettingDataModel {
  String about;
  String terms;


  SettingDataModel.fromJson(Map<String, dynamic> json) {
    about = json['about'];
    terms = json['terms'];
  }

}
