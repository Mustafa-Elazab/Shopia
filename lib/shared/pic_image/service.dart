import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shop_app2/Helper/compoments.dart';
import 'package:shop_app2/modeuls/shop_screen/bloc/shopcubit.dart';

class ImageService{
  static Future<dynamic> uploadFile(filePath) async {
    //jwt authentication token
    var authToken = TOKEN;
    //user im use to upload image
    //Note: this authToken and user id parameter will depend on my backend api structure
    //in your case it can be only auth token
    var _userId = '1767';

    try {
      FormData formData =
      new FormData.fromMap({
        "image":
        await MultipartFile.fromFile(filePath, filename: "dp")});

      Response response =
      await Dio().put(
          "https://student.valuxapps.com/api/update-profile$_userId",
          data: formData,
          options: Options(
              headers: <String, String>{
                'Authorization': 'Bearer $authToken',
              }
          )
      );
      return response;
    }on DioError catch (e) {
      return e.response;
    } catch(e){
    }
  }
}