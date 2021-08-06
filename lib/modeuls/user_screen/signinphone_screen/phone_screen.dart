import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:shop_app2/Helper/HelperMethods.dart';
import 'package:shop_app2/modeuls/user_screen/vertife_phone_screen/vertification_screen.dart';
class PhoneScreen extends StatelessWidget {
  var FormKey=GlobalKey<FormState>();
  TextEditingController phoneController=new TextEditingController();
  @override
  Widget build(BuildContext context) {
  return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('OTP Sign In',style: TextStyle(
              fontSize: 20.0,
              color: Colors.black54
          ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Form(
          key: FormKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20.0,),
                Center(child: Text('OTP Sign In',style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold
                ),)),
                SizedBox(height: 20.0,),
                Text('Sign in with your phone number or continue with social media',textAlign:TextAlign.center ,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(height: 50.0,),
              defaultTextFormField(controller: phoneController, type: TextInputType.phone, label: 'Phone Number', validate_message: 'phone number must be not empty'
                  ,prefixIcon: Icons.phone),
              SizedBox(height: 20,),
              buildBtn((){
                if(FormKey.currentState.validate()){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>
                  VertificationScreen(),
                  settings: RouteSettings(
                    name: phoneController.text
                  ),
                  ),
                  );

                }
              },'Continue'),
              SizedBox(height: 20,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildSocialImage(Buttons.Twitter, (){

                  }),
                  buildSocialImage(Buttons.Email, (){

                  }),
                  buildSocialImage(Buttons.Facebook, (){

                  }),
                ],
              )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
