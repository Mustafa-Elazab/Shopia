import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:shop_app2/Helper/HelperMethods.dart';
import 'package:shop_app2/model/shop/notification/notification_model.dart';
import 'package:shop_app2/modeuls/shop_screen/bloc/shopcubit.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Notification',
            style: TextStyle(fontSize: 20.0, color: Colors.black54),
          ),
        ),
      ),
      body: ConditionalBuilder(
        condition: ShopCubit.get(context).notificationModel!=null,
        builder: (context)=> ListView.separated(physics: BouncingScrollPhysics(),
            itemBuilder: (context,index)=> buildNotifiy(ShopCubit.get(context).notificationModel.data.data[index]),
            separatorBuilder: (context,index)=>SizedBox(height: 10,),
            itemCount: ShopCubit.get(context).notificationModel.data.data.length),
        fallback: (context)=>Center(child: CircularProgressIndicator()),
      ),
    );


  }

  Widget buildNotifiy(NotifiyData notifiyData)=>Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
    child: Container(
      padding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 10,
      ),
      // height: 174,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(notifiyData.title
            ,style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold
            ),),
          SizedBox(height:10.0),
          Text(notifiyData.message
            ,style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w300
            ),),
        ],
      ),
    ),
  );
}
