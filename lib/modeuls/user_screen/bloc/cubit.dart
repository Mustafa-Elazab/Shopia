
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app2/Helper/HelperMethods.dart';
import 'package:shop_app2/Helper/compoments.dart';
import 'package:shop_app2/model/user/user_login_data.dart';
import 'file:///D:/flutter%20project/shop_app2/lib/modeuls/user_screen/bloc/states.dart';
import 'package:shop_app2/shared/network/remote/dio.dart';
import 'package:shop_app2/shared/network/remote/end_points.dart';

class UserCubit extends Cubit<UserStates> {
    UserCubit() : super(UserLoginIntinalState());

  static UserCubit get(context) => BlocProvider.of(context);


    UserModel userModel;

    void userLogin({
    @required String email,
    @required String password,
}){

    emit(UserLoginLoadingState());
    DioHelper.postData(url: LOGIN, data: {
      'email':email,
      'password':password,
    },).then((value){
      userModel = UserModel.fromJson(value.data);
      if(userModel.status){
        toast(message: userModel.message, color: Colors.green);
      }else{
        toast(message: userModel.message, color: Colors.red);
      }
      emit(UserLoginSucessState(userModel));
    }).catchError((error){
      print(error.toString());
      emit(UserLoginErrorState(error.toString()));
    });
  }

  bool isPasswordShow=true;
  IconData suffixIcon = Icons.visibility_outlined;

  void passwordVisability(){

    isPasswordShow=!isPasswordShow;
    suffixIcon= isPasswordShow ? Icons.visibility_off_outlined:Icons.visibility_outlined;

    emit(UserShowPasswordState());
  }

    UserModel userRegisterModel;

    void userRegister({
      @required String name,
      @required String phone,
      @required String email,
      @required String password,
      String image,

    }) {
      emit(UserRegisterLoadingState());

      DioHelper.postData(url: REGISTER, data:
        {
          'name':name,
          'phone':phone,
          'email':email,
          'password':password,
          'image':image,
        }
      ).then((value){
        userRegisterModel = UserModel.fromJson(value.data);
        if(userRegisterModel.status){
          toast(message: userRegisterModel.message, color: Colors.green);
        }else{
          toast(message: userRegisterModel.message, color: Colors.red);
        }
        emit(UserRegisterSucessState(userRegisterModel));


      }).catchError((error){
        print(error);
        emit(UserRegisterErrorState());
      });
    }
}

