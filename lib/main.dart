import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app2/modeuls/onBoarding_screen/onBoarding_screen.dart';
import 'package:shop_app2/modeuls/shop_screen/bloc/shopcubit.dart';
import 'file:///D:/flutter%20project/shop_app2/lib/modeuls/user_screen/bloc/cubit.dart';
import 'package:shop_app2/modeuls/user_screen/login_screen/login_screen.dart';
import 'package:shop_app2/shared/bloc/cubit.dart';
import 'package:shop_app2/shared/bloc/myblocobserver.dart';
import 'package:shop_app2/shared/bloc/states.dart';
import 'package:shop_app2/shared/network/local/sharedpreferenceHelper.dart';
import 'package:shop_app2/shared/network/remote/dio.dart';
import 'package:shop_app2/shared/styles/themes.dart';

import 'layout/shop_layout/home_layout.dart';
import 'modeuls/shop_screen/search/searchCubit.dart';

void main() async{
  WidgetsFlutterBinding();
  Bloc.observer = MyBlocObserver();
  await DioHelper.init();
  await CacheHelper.init();

  Widget widget;

  bool onBoarding = CacheHelper.sharedPreferences.get('onBoarding');
  String token = CacheHelper.sharedPreferences.get('token');
  String password = CacheHelper.sharedPreferences.get('password');


  if(onBoarding !=null){
    if(token != null)widget =ShopHomeScreen();
    else  widget=LoginScreen();
  }else{
    widget=onBoardingScreen();
  }

  runApp(MyApp(startWidget: widget,
    token: token,password: password,));
}

class MyApp extends StatelessWidget {

  final Widget startWidget ;
  final String token;
  final String password;
   MyApp({this.startWidget, this.token,this.password});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>AppCubit(),),
        BlocProvider(create: (context)=>UserCubit(),),
        BlocProvider(create: (context)=> SearchCubit(),),
        BlocProvider(create: (context)=>ShopCubit()..getHomeData()..getCategoriesData()..getFavoritesProduct()..getUserData()..getCartItem()..getNotification()..getSettingData()..getHelpCenterData()),
      ],

      child: BlocConsumer<AppCubit,AppStates>(
        listener:(context,state){

        } ,
        builder: (context,state){
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: ThemeMode.light,
              home: startWidget,
          );
        },
      ),
    );
  }
}



