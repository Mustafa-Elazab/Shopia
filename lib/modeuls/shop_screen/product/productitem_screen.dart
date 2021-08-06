import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app2/Helper/HelperMethods.dart';
import 'package:shop_app2/model/shop/home_shop_model.dart';
import 'package:shop_app2/model/shop/search/searchmodel.dart';
import 'package:shop_app2/modeuls/shop_screen/bloc/shopcubit.dart';
import 'package:shop_app2/modeuls/shop_screen/bloc/shopstates.dart';
import 'package:shop_app2/shared/styles/color.dart';

class ProductDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   final model = ModalRoute.of(context).settings.arguments as ProductModel;
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              model.name,
              maxLines: 1,
            ),
          ),
          bottomNavigationBar: BuildNavBtn(context,model),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.topStart,
                      children: [
                        Image(
                          image: NetworkImage(model.image),
                          width: double.infinity,
                          height: 200.0,
                        ),
                        if (model.discount != 0)
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Container(
                              color: Colors.red,
                              child: Text(
                                'DISCOUNT',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.name,
                          style: TextStyle(fontSize: 16.0, height: 1.2),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        Row(
                          children: [
                            Text(
                              model.price.toString(),
                              style: TextStyle(
                                  fontSize: 16.0,
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
                                    fontSize: 16.0,
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
                                ShopCubit.get(context)
                                    .changeFavorites(model.id);
                                print(model.id);
                              },
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Description :',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: double.infinity,
                          height: 300,
                          child: ListView.separated(
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) => ListTile(
                                    title: Text(model.description),
                                  ),
                              separatorBuilder: (context, index) => MyDivder(),
                              itemCount: 1),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget BuildNavBtn(context,model) => Container(
        padding: EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 30,
        ),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -15),
              blurRadius: 20,
              color: Color(0xFFDADADA).withOpacity(0.15),
            )
          ],
        ),
        child: SafeArea(
            child:
                SizedBox(width: 200.0, child: buildBtn(() {
      ShopCubit.get(context).addCartItem(model.id);
      Navigator.pop(context);
  }, 'Add to cart'))),
      );
}
