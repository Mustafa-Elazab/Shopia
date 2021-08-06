import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app2/modeuls/shop_screen/bloc/shopcubit.dart';
import 'package:shop_app2/modeuls/shop_screen/bloc/shopstates.dart';
import 'package:shop_app2/modeuls/shop_screen/search/searchCubit.dart';
import 'package:shop_app2/modeuls/shop_screen/search/searchScreen.dart';
import 'package:shop_app2/modeuls/shop_screen/search/searchState.dart';

class ShopHomeScreen extends StatefulWidget {

  @override
  _ShopHomeScreenState createState() => _ShopHomeScreenState();
}

class _ShopHomeScreenState extends State<ShopHomeScreen> {
  ShopCubit shopCubit;
  SearchCubit searchCubit;


  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text('Yes'),
          ),
        ],
      ),
    )) ?? false;
  }


  @override
  Widget build(BuildContext context) {
    
    shopCubit = ShopCubit.get(context);
    searchCubit=SearchCubit.get(context);

    return BlocProvider(
      create: (context)=>BlocProvider.of(context),
      child: BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){
        },
        builder: (context,state){
          return new WillPopScope(
            onWillPop: _onWillPop,
            child: Scaffold(
              body: shopCubit.screens[shopCubit.current_index],
              bottomNavigationBar: BottomNavigationBar(
                items:shopCubit.bottomItem,
                currentIndex: shopCubit.current_index,
                onTap: (index){
                  shopCubit.changebottomnavbar(index);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
