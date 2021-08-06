import 'package:bloc/bloc.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app2/model/shop/search/searchmodel.dart';
import 'package:shop_app2/model/shop/favorites/favoritesmodel.dart';
import 'package:shop_app2/modeuls/onBoarding_screen/onBoarding_screen.dart';
import 'package:shop_app2/modeuls/shop_screen/bloc/shopcubit.dart';
import 'package:shop_app2/modeuls/shop_screen/cart/cart_screen.dart';
import 'package:shop_app2/shared/styles/color.dart';
import 'package:shop_app2/shared/styles/styles.dart';

Widget ArticalItem(
  artical,
  context,
) =>
    InkWell(
      onTap: () {
        NavigateTo(context, artical());
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 120.0,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage('${artical['urlToImage']}'),
                ),
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Container(
                height: 120.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        artical['title'],
                        style: Theme.of(context).textTheme.bodyText1,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      artical['publishedAt'],
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

Widget MyDivder() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 20),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[200],
      ),
    );

Widget conditionBuilder(list, context, {isSearch = false}) =>
    ConditionalBuilder(
      condition: list.length > 0,
      builder: (context) => ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) => ArticalItem(list[index], context),
          separatorBuilder: (context, index) => MyDivder(),
          itemCount: list.length),
      fallback: (context) =>
          isSearch ? Container() : Center(child: CircularProgressIndicator()),
    );

Widget defaultTextFormField({
  @required TextEditingController controller,
  IconData prefixIcon,
  @required TextInputType type,
  @required String label,
  String hint,
  @required String validate_message,
  Function onChange,
  Function onTap,
  bool isClickable = true,
  obscureText = false,
  Function onSubmit,
  Function onPressedSuffix,
  IconData suffix,
}) =>
    TextFormField(
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(color: default_color),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(
            color: default_color,
            width: 2.0,
          ),
        ),
        prefixIcon: Icon(
          prefixIcon,
          color: default_color,
        ),
        suffixIcon: IconButton(
          icon: Icon(suffix),
          onPressed: onPressedSuffix,
        ),
        labelText: label,
        border: OutlineInputBorder(),
        hintText: hint,
      ),
      controller: controller,
      onChanged: onChange,
      onFieldSubmitted: onSubmit,
      obscureText: obscureText,
      enabled: isClickable,
      onTap: onTap,
      validator: (String value) {
        if (value.isEmpty) {
          return validate_message;
        }
        return null;
      },
      keyboardType: type,
    );

void NavigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );

void Navigate_Finsih(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => widget),
    (Route<dynamic> route) => false);

Widget buildonBorder(BoardingModel model) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 40.0,
        ),
        Center(
          child: Text(
            '${model.title}',
            style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: default_color),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Center(
          child: Text(
            '${model.body}',
            style: TextStyle(fontSize: 16.0),
          ),
        ),
        Expanded(
          child: Image(
            image: AssetImage('${model.image}'),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
      ],
    );

Widget buildForgotPasswordBtn({Function onPreesed}) => Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: onPreesed,
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          'Forgot Password?',
        ),
      ),
    );

bool rememberMe = false;

Widget buildBtn(Function onPressed, String BtnName) => SizedBox(
      width: double.infinity,
      height: 48.0,
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: default_color,
        onPressed: onPressed,
        child: Text(
          BtnName,
          style: TextStyle(
              fontFamily: 'OpenSans', color: Colors.white, fontSize: 20),
        ),
      ),
    );

Widget buildSocialImage(Buttons socialBtn, Function onPresssed) => SignInButton(
      socialBtn,
      mini: true,
      onPressed: onPresssed,
    );

void toast({
  @required String message,
  @required Color color,
}) =>
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0);

Widget defaultTextForm({
  @required TextEditingController controller,
  @required TextInputType type,
  String label,
  IconData prefixIcon,
  String hint,
  @required String validate_message,
  Function onChange,
  Function onTap,
  obscureText = false,
  Function onSubmit,
}) =>
    TextFormField(
      decoration: InputDecoration(
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(
          prefixIcon,
          color: default_color,
        ),
      ),
      controller: controller,
      onChanged: onChange,
      onFieldSubmitted: onSubmit,
      obscureText: obscureText,
      onTap: onTap,
      keyboardType: type,
    );

Widget homeHeader(BuildContext context) => Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SearchField(),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              NavigateTo(context, CartScreren());
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              NavigateTo(context, CartScreren());
            },
          ),
        ],
      ),
    );

Widget SearchField() => Container(
      width: 200.0,
      decoration: BoxDecoration(
        color: default_color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        onChanged: (value) => print(value),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            hintText: "Search product",
            prefixIcon: Icon(Icons.search)),
      ),
    );
