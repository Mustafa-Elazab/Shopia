import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app2/Helper/HelperMethods.dart';
import 'package:shop_app2/Helper/compoments.dart';
import 'package:shop_app2/layout/shop_layout/home_layout.dart';
import 'package:shop_app2/modeuls/onBoarding_screen/onBoarding_screen.dart';
import 'package:shop_app2/modeuls/shop_screen/cart/cart_screen.dart';
import 'package:shop_app2/modeuls/shop_screen/home/home_screen.dart';
import 'package:shop_app2/modeuls/shop_screen/profile/help_center/help_center.dart';
import 'package:shop_app2/modeuls/shop_screen/profile/notification/notifications_screen.dart';
import 'package:shop_app2/modeuls/shop_screen/profile/settings/setting.dart';
import 'package:shop_app2/modeuls/user_screen/login_screen/login_screen.dart';
import 'package:shop_app2/modeuls/user_screen/update_screen/update_profile_screen.dart';
import 'package:shop_app2/shared/network/local/sharedpreferenceHelper.dart';
import 'package:shop_app2/shared/styles/color.dart';
class ProfileScreen extends StatelessWidget {





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(
            child: Text('Profile',style: TextStyle(
                fontSize: 20.0,
                color: Colors.black54
            ),
            ),
          ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 70,
                backgroundImage: NetworkImage('https://pbs.twimg.com/profile_images/1404925622560997380/njmEfnHF_400x400.jpg'),
              ),
            ),
            SizedBox(height: 30.0,),
            FlatButton(
                padding: EdgeInsets.all(16.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                color: Color(0xFFF5F6F9),
                onPressed: (){
                  NavigateTo(context,UpdateProfileScreen());
                }, child: Row(
              children: [
                Icon(Icons.person_outline,color: default_color,),
                SizedBox(width: 20.0,),
                Expanded(child:
                Text(
                  'My Account',
                  style: TextStyle(
                      fontSize: 18,fontWeight: FontWeight.w300,
                      color: Colors.black45
                  ),
                )),
                Spacer(),
                Icon(Icons.arrow_forward_ios_rounded,color: Colors.black45,),
              ],
            )),
            SizedBox(height: 30.0,),
            MyDivder(),
            FlatButton(
                padding: EdgeInsets.all(16.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                color: Color(0xFFF5F6F9),
                onPressed: (){
                  NavigateTo(context,NotificationScreen());
                }, child: Row(
              children: [
                Icon(Icons.notifications_none_rounded,color: default_color,),
                SizedBox(width: 20.0,),
                Expanded(child:
                Text(
                  'Notifications',
                  style: TextStyle(
                      fontSize: 18,fontWeight: FontWeight.w300,
                      color: Colors.black45
                  ),
                )),
                Spacer(),
                Icon(Icons.arrow_forward_ios_rounded,color: Colors.black45,),
              ],
            )),
            SizedBox(height: 30.0,),
            MyDivder(),
            FlatButton(
                padding: EdgeInsets.all(16.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                color: Color(0xFFF5F6F9),
                onPressed: (){
                  NavigateTo(context,SettingScreen());
                }, child: Row(
              children: [
                Icon(Icons.settings,color: default_color,),
                SizedBox(width: 20.0,),
                Expanded(child:
                Text(
                  'Settings',
                  style: TextStyle(
                      fontSize: 18,fontWeight: FontWeight.w300,
                      color: Colors.black45
                  ),
                )),
                Spacer(),
                Icon(Icons.arrow_forward_ios_rounded,color: Colors.black45,),
              ],
            )),
            SizedBox(height: 30.0,),
            MyDivder(),
            FlatButton(
                padding: EdgeInsets.all(16.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                color: Color(0xFFF5F6F9),
                onPressed: (){
                  NavigateTo(context,HelpCenterScreen());
                }, child: Row(
              children: [
                Icon(Icons.help_outline_outlined,color: default_color,),
                SizedBox(width: 20.0,),
                Expanded(child:
                Text(
                  'Help Center',
                  style: TextStyle(
                      fontSize: 18,fontWeight: FontWeight.w300,
                      color: Colors.black45
                  ),
                )),
                Spacer(),
                Icon(Icons.arrow_forward_ios_rounded,color: Colors.black45,),
              ],
            )),
            SizedBox(height: 30.0,),
            MyDivder(),
            FlatButton(
              padding: EdgeInsets.all(16.0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              color: Color(0xFFF5F6F9),
              onPressed: (){
                 showDialog(
                    context: context, builder: (context) => new AlertDialog(
                  title: new Text('Are you sure?'),
                  content: new Text('Do you want to Log out'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: new Text('No'),
                    ),
                    TextButton(
                      onPressed: () {
                        CacheHelper.removeData();
                        Navigate_Finsih(context,onBoardingScreen());
                        SystemNavigator.pop();
                      },
                      child: new Text('Yes'),
                    ),
                  ],
                ),
                );


              }, child: Row(
              children: [
                Icon(Icons.login_rounded,color: default_color,),
                SizedBox(width: 20.0,),
                Expanded(child:
                Text(
                  'Log Out',
                  style: TextStyle(
                      fontSize: 18,fontWeight: FontWeight.w300,
                      color: Colors.black45
                  ),
                )),
                Spacer(),
                Icon(Icons.arrow_forward_ios_rounded,color: Colors.black45,),
              ],
            ),
            ),
          ],
        ),
      ),

    );

  }



}
