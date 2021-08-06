import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app2/Helper/HelperMethods.dart';
import 'package:shop_app2/model/shop/categories/categories_model.dart';
import 'package:shop_app2/modeuls/shop_screen/bloc/shopcubit.dart';
import 'package:shop_app2/modeuls/shop_screen/bloc/shopstates.dart';
import 'package:shop_app2/modeuls/shop_screen/home/home_screen.dart';
class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
              title: Center(
                child: Text('Categories',style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black54
                ),
                ),
              ),
          ),
          body: ConditionalBuilder(
            condition: ShopCubit.get(context).categoriesModel !=null&& state is! ShopCategoriesGetDataErrorState,
            builder: (context)=>  ListView.separated(physics: BouncingScrollPhysics(),
                itemBuilder:(context,index)=> buildCategory(ShopCubit.get(context).categoriesModel.data.data[index]),
                separatorBuilder:(context,index)=> MyDivder(),
                itemCount: ShopCubit.get(context).categoriesModel.data.data.length),
            fallback: (context)=> Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }

  Widget buildCategory(DataModel dataModel)=> Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image(image: NetworkImage(dataModel.image),
              height: 150.0,
              width: 150.0,
              ),
            SizedBox(width: 10.0,),
            Text(dataModel.name,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold
              ),),
            Spacer(),
            IconButton(icon: Icon(Icons.arrow_forward_ios_rounded), onPressed: (){}),
          ],
        )

      ],
    ),
  );
}
