class HelpCenterModel {
  bool status;
  String message;
  HelpCenterDataModel data;



  HelpCenterModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new HelpCenterDataModel.fromJson(json['data']) : null;
  }

}

class HelpCenterDataModel {
  int currentPage;
  List<HelpCenterData> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  Null nextPageUrl;
  String path;
  int perPage;
  Null prevPageUrl;
  int to;
  int total;


  HelpCenterDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = new List<HelpCenterData>();
      json['data'].forEach((v) {
        data.add(new HelpCenterData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

}

class HelpCenterData {
  int id;
  String question;
  String answer;



  HelpCenterData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
  }

}
