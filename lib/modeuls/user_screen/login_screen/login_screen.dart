import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:shop_app2/Helper/HelperMethods.dart';
import 'package:shop_app2/Helper/compoments.dart';
import 'package:shop_app2/layout/shop_layout/home_layout.dart';
import 'package:shop_app2/model/user/user_login_data.dart';
import 'file:///D:/flutter%20project/shop_app2/lib/modeuls/user_screen/bloc/cubit.dart';
import 'file:///D:/flutter%20project/shop_app2/lib/modeuls/user_screen/bloc/states.dart';
import 'package:shop_app2/modeuls/user_screen/register_screen/register_screen.dart';
import 'package:shop_app2/modeuls/user_screen/restpassword_screen/resetpassword.dart';
import 'package:shop_app2/modeuls/user_screen/signinphone_screen/phone_screen.dart';
import 'package:shop_app2/shared/network/local/sharedpreferenceHelper.dart';
import 'package:shop_app2/shared/styles/styles.dart';

class LoginScreen extends StatelessWidget {
  var FormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    TextEditingController emailController=new TextEditingController();
    TextEditingController passwordController=new TextEditingController();
    return BlocProvider(
      create: (context)=> UserCubit(),
      child: BlocConsumer<UserCubit,UserStates>(
        listener: (context,state){

           if(state is UserLoginSucessState){
             if(state.userModel.status){
               print(state.userModel.data.token);
               String token = state.userModel.data.token;
               String password=passwordController.text;
               CacheHelper.saveData(key: 'password', value:password);
               CacheHelper.saveData(key: 'token', value: token).then((value){
                 Navigate_Finsih(context,ShopHomeScreen());
               });
               print(state.userModel.data.token);
               print(state.userModel.message);
               print(password.toString());


             }else{
               print(state.userModel.message);
             }
           }
        },
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(
              title: Center(
                child: Text('Sign In',style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black54
                ),
                ),
              ),
              leading: Icon(Icons.arrow_back_ios,
                size: 15,
              ),
            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: FormKey,
                  child: Column(
                    children: [
                      SizedBox(height: 20.0,),
                      Center(child: Text('Welcome Back',style: TextStyle(
                          fontSize: 28,
                        fontWeight: FontWeight.bold
                      ),)),
                      SizedBox(height: 20.0,),
                      Text('Sign in with your email and password or continue with social media',textAlign:TextAlign.center ,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                      ),
                      SizedBox(height: 50.0,),
                      defaultTextFormField(controller: emailController, type: TextInputType.emailAddress,
                          label: 'Email', validate_message: 'Email Must be not Empty'
                          ,prefixIcon: Icons.person_outline),
                      SizedBox(height: 20.0,),
                      defaultTextFormField(controller: passwordController, type: TextInputType.text,
                          label: 'Password', validate_message: 'Password Must be not Empty'
                          ,prefixIcon: Icons.lock_outlined,
                          suffix: UserCubit.get(context).suffixIcon,
                          obscureText: UserCubit.get(context).isPasswordShow,
                          onPressedSuffix: (){

                                 UserCubit.get(context).passwordVisability();
                                 print(UserCubit.get(context).isPasswordShow);
                          },

                       ),
                      buildForgotPasswordBtn(
                          onPreesed: (){
                            NavigateTo(context, ResetScreen());

                          }
                      ),
                      SizedBox(height: 20.0,),
                      ConditionalBuilder(condition: state is! UserLoginLoadingState,
                        builder:(context)=> buildBtn((){
                        if (FormKey.currentState.validate()){
                          UserCubit.get(context).userLogin(email:emailController.text,
                              password:passwordController.text);
                        }
                      },'Sign In'),
                        fallback:(context)=> Center(child: CircularProgressIndicator()), ),
                      SizedBox(height: 20.0,),
                      Text(
                        '- OR -',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextButton(onPressed: (){
                        NavigateTo(context, PhoneScreen());
                      }
                        ,child: Text(
                          'Sign in Via OTP',
                          style: kLabelStyle,
                        ),
                      ),
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
                      ),

                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '''Don't have an account ?''',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextButton(onPressed: (){
                              NavigateTo(context, RegisterScreen());
                            }
                              ,child: Text(
                                'Sign Up',
                                style: kLabelStyle,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
