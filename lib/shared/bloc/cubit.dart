import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app2/Helper/HelperMethods.dart';
import 'package:shop_app2/Helper/compoments.dart';
import 'package:shop_app2/model/shop/search/searchmodel.dart';
import 'package:shop_app2/shared/bloc/states.dart';
import 'package:shop_app2/shared/network/local/sharedpreferenceHelper.dart';
import 'package:shop_app2/shared/network/remote/dio.dart';
import 'package:shop_app2/shared/network/remote/end_points.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppIntinalState());

  static AppCubit get(context) => BlocProvider.of(context);

  var isDark=false;
  void changeAppMode(){
    isDark=!isDark;
    CacheHelper.saveData(key: 'isDark', value: isDark).then((value){
      emit(ModeAppChangeState());
    });
    print(isDark);
  }

}