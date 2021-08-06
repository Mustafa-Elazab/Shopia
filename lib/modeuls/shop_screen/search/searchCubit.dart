import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app2/Helper/compoments.dart';
import 'package:shop_app2/model/shop/search/searchmodel.dart';
import 'package:shop_app2/modeuls/shop_screen/search/searchState.dart';
import 'package:shop_app2/shared/network/remote/dio.dart';
import 'package:shop_app2/shared/network/remote/end_points.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchIntinalState());

  static SearchCubit get(context) => BlocProvider.of(context);


  ItemModel itemModel;

  void getSearchData(String text) {
    emit(SearchLoadingDataState());
    DioHelper.postData(
        url: PRODUCT_SEARCH,
        authorization: TOKEN,
        data: {'text': text}).then((value) {
      itemModel = ItemModel.fromJson(value.data);
      if (itemModel.status) {
        print(itemModel.status);
        print("the search data ${itemModel.data.data}");
        emit(SearchSucessDataState());

      }
    }).catchError((error) {
      print("error ${error}");
      emit(SearchErrorDataState(error));
    });
  }
}