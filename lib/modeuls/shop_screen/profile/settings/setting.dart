import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app2/Helper/HelperMethods.dart';
import 'package:shop_app2/model/shop/settings/setting_model.dart';
import 'package:shop_app2/modeuls/shop_screen/bloc/shopcubit.dart';
import 'package:shop_app2/modeuls/shop_screen/bloc/shopstates.dart';
class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){},
        builder:(context,state){

          return Scaffold(
              appBar: AppBar(
                title: Center(
                  child: Text('Settings',style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black54
                  ),
                  ),
                ),
              ),
              body: ConditionalBuilder(
                                 condition: ShopCubit.get(context).settingModel!=null,
                                 builder: (context)=>buildSetting(ShopCubit.get(context).settingModel.data,context),
                                 fallback: (context)=> Center(child: CircularProgressIndicator()),
          ),
          );
        } ,
      );



  }

  Widget buildSetting(SettingDataModel data, BuildContext context)=>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.grey[100]
                ),
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('About:-',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                    ),
                    SizedBox(height: 10.0,),
                    Text(data.about,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w300
                    ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.0,),

              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.grey[100]
                ),
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Terms:-',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(data.terms,
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w300
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
