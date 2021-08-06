import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app2/Helper/HelperMethods.dart';
import 'package:shop_app2/model/shop/favorites/favoritesmodel.dart';
import 'package:shop_app2/modeuls/shop_screen/bloc/shopcubit.dart';
import 'package:shop_app2/modeuls/shop_screen/bloc/shopstates.dart';
import 'package:shop_app2/modeuls/shop_screen/home/home_screen.dart';
import 'package:shop_app2/shared/styles/color.dart';

class FavouriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
              title: Center(
                child: Text('Favourites',style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black54
                ),
                ),
              ),
          ),
          body: ConditionalBuilder(
            condition: ShopCubit.get(context).favouritesModel!=null,
            builder: (context)=> ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildFavoritesItem(
                    ShopCubit.get(context).favouritesModel.data.data[index].product,
                    context),
                separatorBuilder: (context, index) => MyDivder(),
                itemCount: ShopCubit.get(context).favouritesModel.data.data.length),
            fallback: (context)=> Center(child: CircularProgressIndicator()),

          ),
        );
      },
    );
  }

  Widget buildFavoritesItem(Product model, context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 100.0,
          color: Colors.white,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    Image(
                      image: NetworkImage(model.image),
                    ),
                    if (model.discount != 0)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          color: Colors.red,
                          child: Text(
                            'DISCOUNT',
                            style: TextStyle(
                              fontSize: 8.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.name,
                        style: TextStyle(fontSize: 14.0, height: 1.2),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Text(
                            model.price.toString(),
                            style: TextStyle(
                                fontSize: 14.0,
                                height: 1.1,
                                color: default_color,
                                fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          if (model.discount != 0)
                            Text(
                              model.oldPrice.toString(),
                              style: TextStyle(
                                  fontSize: 14.0,
                                  height: 1.1,
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough),
                              overflow: TextOverflow.ellipsis,
                            ),
                          Spacer(),
                          IconButton(
                            icon: CircleAvatar(
                              radius: 20.0,
                              backgroundColor: ShopCubit.get(context)
                                      .favourite[model.id]
                                  ? Colors.lightBlue
                                  : Colors.grey,
                              child: Icon(
                                Icons.favorite_border,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              ShopCubit.get(context).changeFavorites(model.id);
                              print(model.id);
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
