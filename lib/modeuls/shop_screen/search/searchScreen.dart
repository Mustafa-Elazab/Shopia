import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app2/Helper/HelperMethods.dart';
import 'package:shop_app2/model/shop/home_shop_model.dart';
import 'package:shop_app2/model/shop/search/searchmodel.dart';
import 'package:shop_app2/modeuls/shop_screen/bloc/shopcubit.dart';
import 'package:shop_app2/modeuls/shop_screen/bloc/shopstates.dart';
import 'package:shop_app2/modeuls/shop_screen/cart/cart_screen.dart';
import 'package:shop_app2/modeuls/shop_screen/home/home_screen.dart';
import 'package:shop_app2/modeuls/shop_screen/product/productitem_screen.dart';
import 'package:shop_app2/modeuls/shop_screen/profile/notification/notifications_screen.dart';
import 'package:shop_app2/modeuls/shop_screen/search/searchCubit.dart';
import 'package:shop_app2/modeuls/shop_screen/search/searchState.dart';
import 'package:shop_app2/shared/styles/color.dart';

class SearchScreen extends StatelessWidget {
  TextEditingController controller = new TextEditingController();
  var formKey = GlobalKey<FormState>();
  TextEditingController search_controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BlocProvider.of(context),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Container(
                decoration: BoxDecoration(
                  color: default_color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: defaultTextForm(
                  controller: search_controller,
                  type: TextInputType.text,
                  hint: 'Search',
                  prefixIcon: Icons.search,
                  onSubmit: (String value) {
                    SearchCubit.get(context).getSearchData(value);
                    search_controller.clear();
                  },
                ),
              ),
            ),
            body: ConditionalBuilder(
              condition: SearchCubit.get(context).itemModel != null,
              builder: (context) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    if (state is SearchLoadingDataState)
                      LinearProgressIndicator(),
                    SizedBox(
                      height: 20,
                    ),
                    if (state is SearchSucessDataState)
                      Expanded(
                        child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) => buildItem(
                                SearchCubit.get(context)
                                    .itemModel
                                    .data
                                    .data[index],
                                context),
                            separatorBuilder: (context, index) => MyDivder(),
                            itemCount: SearchCubit.get(context)
                                .itemModel
                                .data
                                .data
                                .length),
                      )
                    /*  Expanded(
                    */ /*  child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) => buildItem(
                              ShopCubit.get(context).searchModel.data.data[index],
                              context),
                          separatorBuilder: (context, index) => MyDivder(),
                          itemCount: ShopCubit.get(context).searchModel.data.data.length),*/ /*
                    ),*/
                  ],
                ),
              ),
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
          );
        },
      ),
    );
  }

  Widget buildItem(Item model, context) => InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailScreen(),
              settings: RouteSettings(arguments: model),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    Image(
                      image: NetworkImage(model.image),
                      width: double.infinity,
                      height: 200.0,
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
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.name,
                        style: TextStyle(fontSize: 14.0, height: 1.2),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
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
                            width: 15.0,
                          ),
                          Spacer(),
                          IconButton(
                            icon: CircleAvatar(
                              radius: 20.0,
                              backgroundColor:
                                  ShopCubit.get(context).favourite[model.id]
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
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
