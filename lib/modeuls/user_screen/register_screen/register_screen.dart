import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:shop_app2/Helper/HelperMethods.dart';
import 'package:shop_app2/layout/shop_layout/home_layout.dart';
import 'file:///D:/flutter%20project/shop_app2/lib/modeuls/user_screen/bloc/cubit.dart';
import 'file:///D:/flutter%20project/shop_app2/lib/modeuls/user_screen/bloc/states.dart';


class RegisterScreen extends StatelessWidget {
  var FormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = new TextEditingController();
    TextEditingController phoneController = new TextEditingController();
    TextEditingController emailController = new TextEditingController();
    TextEditingController passwordController = new TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Sign Up',style: TextStyle(
              fontSize: 20.0,
              color: Colors.black54
          ),
          ),
        ),
      ),
      body: BlocConsumer<UserCubit, UserStates>(
        listener: (context, state) {
          if (state is UserRegisterSucessState) {
            if (state.userModel.status) {
              print(state.userModel.data.token);
              print(state.userModel.message);

              NavigateTo(context, ShopHomeScreen());
            } else {
              print(state.userModel.message);
            }
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Form(
              key: FormKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(height: 20.0,),
                    Center(child: Text('Register Account ',style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold
                    ),)),
                    SizedBox(height: 20.0,),
                    Text('Complete your detail or continue with social media',textAlign:TextAlign.center ,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(height: 30.0,),
                    defaultTextFormField(
                        controller: nameController,
                        type: TextInputType.text,
                        label: "Name",
                        validate_message: 'Name must not be empty',
                        prefixIcon: Icons.person),
                    SizedBox(
                      height: 20.0,
                    ),
                    defaultTextFormField(
                        controller: phoneController,
                        type: TextInputType.phone,
                        label: "Phone",
                        validate_message: 'Phone must not be empty',
                        prefixIcon: Icons.phone),
                    SizedBox(
                      height: 20.0,
                    ),
                    defaultTextFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        label: "Email",
                        validate_message: 'Email must not be empty',
                        prefixIcon: Icons.email),
                    SizedBox(
                      height: 20.0,
                    ),
                    defaultTextFormField(
                      controller: passwordController,
                      type: TextInputType.text,
                      label: "Password",
                      validate_message: 'Password must not be empty',
                      prefixIcon: Icons.lock,
                      suffix: UserCubit.get(context).suffixIcon,
                      obscureText: UserCubit.get(context).isPasswordShow,
                      onPressedSuffix: () {
                        UserCubit.get(context).passwordVisability();
                        print(UserCubit.get(context).isPasswordShow);
                      },
                    ),
                    /* suffixIcon: Icons.visibility),*/
                    SizedBox(
                      height: 40.0,
                    ),
                    ConditionalBuilder(
                        condition: state is! UserRegisterLoadingState,
                        builder: (context) => buildBtn(() {
                              if (FormKey.currentState.validate()) {
                                UserCubit.get(context).userRegister(
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    email: emailController.text,
                                    password: passwordController.text);
                                print('done sign up');
                              }
                            }, 'Continue'),
                        fallback: (context) => CircularProgressIndicator()),
                    SizedBox(height: 20.0,),
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
                    SizedBox(height: 20.0,),
                    Text('By continuing your confirm that you agree with Terms and Condition',textAlign:TextAlign.center ,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ],

                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
