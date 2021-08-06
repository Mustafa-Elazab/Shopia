import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app2/Helper/HelperMethods.dart';
import 'package:shop_app2/model/shop/categories/categories_model.dart';
import 'package:shop_app2/model/shop/home_shop_model.dart';
import 'package:shop_app2/modeuls/shop_screen/bloc/shopcubit.dart';
import 'package:shop_app2/modeuls/shop_screen/bloc/shopstates.dart';
import 'package:shop_app2/modeuls/shop_screen/cart/cart_screen.dart';
import 'package:shop_app2/modeuls/shop_screen/product/productitem_screen.dart';
import 'package:shop_app2/modeuls/shop_screen/search/searchCubit.dart';
import 'package:shop_app2/modeuls/shop_screen/search/searchScreen.dart';
import 'file:///D:/flutter%20project/shop_app2/lib/modeuls/shop_screen/profile/notification/notifications_screen.dart';
import 'package:shop_app2/shared/styles/color.dart';

class HomeScreen extends StatelessWidget {
  var boardController = PageController();
  var carouselController = CarouselController();
  IconData iconData = Icons.favorite_outline;
  TextEditingController search_controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopChangeFavoritesState) {
          if (!state.model.status) {
            toast(message: state.model.message, color: Colors.red);
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Container(
              decoration: BoxDecoration(
                color: default_color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),

              child: InkWell(
                onTap: (){
                  NavigateTo(context, SearchScreen());

                },
                child: Row(
                  children: [
                 IconButton(icon: Icon(Icons.search), onPressed: (){
                   NavigateTo(context, SearchScreen());

                 }),
                  ],
                ),
              ),
            ),

            actions: [
              IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: default_color,
                  ),
                  onPressed: () {
                    NavigateTo(context, CartScreren());
                  }),
              IconButton(
                  icon: Icon(
                    Icons.notifications,
                    color: default_color,
                  ),
                  onPressed: () {
                    NavigateTo(context, NotificationScreen());
                  }),
            ],
          ),
          body:ConditionalBuilder(
            condition: ShopCubit.get(context).shopModel != null &&
                ShopCubit.get(context).categoriesModel != null,
            builder: (context) => buildProducts(
                ShopCubit.get(context).shopModel,
                ShopCubit.get(context).categoriesModel,
                context),
            fallback: (context) => Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }

  Widget buildProducts(
          HomeModel model, CategoriesModel categoriesModel, context) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
                items: model.data.banners
                    .map((e) => Image(
                          image: NetworkImage('${e.image}'),
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ))
                    .toList(),
                options: CarouselOptions(
                  height: 200,
                  initialPage: 0,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal,
                  viewportFraction: 1.0,
                )),
            SizedBox(
              height: 5.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Categories',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    height: 100.0,
                    child: ListView.separated(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => buildCategoryItem(
                            categoriesModel.data.data[index], context),
                        separatorBuilder: (context, index) => SizedBox(
                              width: 10.0,
                            ),
                        itemCount: categoriesModel.data.data.length),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    'New Product',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.grey[100],
              child: GridView.count(
                crossAxisCount: 2,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                childAspectRatio: 1 / 1.7,
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 2.0,
                children: List.generate(
                  model.data.products.length,
                  (index) =>
                      buildGridProduct(model.data.products[index], context),
                ),
              ),
            ),
          ],
        ),
      );

  Widget buildCategoryItem(DataModel dataModel, context) => Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            image: NetworkImage(dataModel.image),
            width: 100.0,
            height: 100.0,
            fit: BoxFit.cover,
          ),
          Container(
            width: 100.0,
            color: Colors.black.withOpacity(0.7),
            child: Text(
              dataModel.name,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 10.0,
                color: Colors.white,
              ),
            ),
          ),
        ],
      );

  Widget buildGridProduct(ProductModel model, context) => InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailScreen(),
              settings: RouteSettings(arguments: model),
            ),
          );
          print(model.description);
        },
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
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
