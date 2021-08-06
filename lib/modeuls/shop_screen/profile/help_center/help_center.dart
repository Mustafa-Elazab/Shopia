import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app2/Helper/HelperMethods.dart';
import 'package:shop_app2/model/help_center/help_center_model.dart';
import 'package:shop_app2/modeuls/shop_screen/bloc/shopcubit.dart';
import 'package:shop_app2/modeuls/shop_screen/bloc/shopstates.dart';

class HelpCenterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                title: Center(
                  child: Text(
                    'Help Center',
                    style: TextStyle(fontSize: 20.0, color: Colors.black54),
                  ),
                ),
              ),
              body: ConditionalBuilder(
          condition: ShopCubit.get(context).helpCenterModel != null,
          builder: (context) => ListView.separated(
            physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildHelpCenter(
                      ShopCubit.get(context).helpCenterModel.data.data[index],
                      context),
                  separatorBuilder: (context, index) => MyDivder(),
                  itemCount: ShopCubit.get(context).helpCenterModel.data.data.length),
                fallback: (context) => Center(child: CircularProgressIndicator()),
              ),
          );
        },
      );
  }

  Widget buildHelpCenter(HelpCenterData centerData, context) =>
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.grey[100]),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(centerData.question,
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(centerData.answer),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      );
}
