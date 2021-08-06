import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app2/Helper/HelperMethods.dart';
import 'package:shop_app2/model/shop/cart/cartmodel.dart';
import 'package:shop_app2/modeuls/shop_screen/bloc/shopcubit.dart';
import 'package:shop_app2/modeuls/shop_screen/bloc/shopstates.dart';
import 'package:shop_app2/shared/styles/color.dart';
class CartScreren extends StatefulWidget {
  @override
  _CartScrerenState createState() => _CartScrerenState();
}

class _CartScrerenState extends State<CartScreren> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
       listener: (context,state){

       },
        builder: (context,state){
         return Scaffold(
             appBar: AppBar(
               title: Center(
                 child: Column(
                   children: [
                     Text('Your Cart'),
                     if(ShopCubit.get(context).cartModel!=null)
                     Text('${ShopCubit.get(context).cartModel.data.cartItems.length}''items',style: TextStyle(
                       fontSize: 12.0,fontWeight: FontWeight.normal
                     ),),
                   ],
                 ),
               ),
             ),

           bottomNavigationBar: ShopCubit.get(context).cartModel!=null? CheckoutCard():null,
             body: ConditionalBuilder(
             condition: ShopCubit.get(context).cartModel!= null,
               builder: (context)=> ListView.separated(
                 physics: BouncingScrollPhysics(),
                   itemBuilder:(context,index)=>
                   Dismissible(
                       key:Key(ShopCubit.get(context).cartModel.data.cartItems[index].product.id.toString()),
                       direction: DismissDirection.endToStart,
                       onDismissed: (direction){
                              setState(() {
                                ShopCubit.get(context).deleteCartItem(ShopCubit.get(context).cartModel.data.cartItems[index].product.id);
                              });
                       },
                       child: buildItem(ShopCubit.get(context).cartModel.data.cartItems[index],context)),
                   separatorBuilder:(context,index)=> MyDivder(),
                   itemCount: ShopCubit.get(context).cartModel.data.cartItems.length),
               fallback: (context)=> Center(child: CircularProgressIndicator()),
             ));
        }
       );
  }

  Widget buildItem(CartItems cartmodel, context) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 170.0,
      color: Colors.white,
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage(cartmodel.product.image,
                    ),
                  ),
                  if (cartmodel.product.discount != 0)
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
                      cartmodel.product.name,
                      style: TextStyle(fontSize: 14.0, height: 1.2),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        Text(
                          cartmodel.product.price.toString(),
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
                        Spacer(),
                      /*  IconButton(
                          icon: CircleAvatar(
                            radius: 20.0,
                            backgroundColor: ShopCubit.get(context)
                                .favourite[cartmodel.product.id]
                                ? Colors.lightBlue
                                : Colors.grey,
                            child: Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            ShopCubit.get(context).changeFavorites(cartmodel.product.id);
                            print(cartmodel.product.id);
                          },
                        )*/
                      ],
                    ),
                    Spacer(),
                    Row(
                      children: [

                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.grey[100],
                          ),
                          child: Row(
                            children: [
                               IconButton(icon: Icon(Icons.remove,size: 20,color: default_color,), onPressed: (){
                                  cartmodel.quantity--;
                                }),

                              Text(cartmodel.quantity.toString(),
                              style: TextStyle(
                                color: default_color,
                              ),),


                              IconButton(icon: Icon(Icons.add,size: 20,color: default_color,), onPressed: (){
                                  cartmodel.quantity++;
                                }),


                            ],
                          ),
                        ),
                            Spacer(),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.grey[100],
                          ),
                          child:IconButton(icon: Icon(Icons.delete_outline_rounded,size: 20,
                          color: default_color,), onPressed: (){
                            ShopCubit.get(context).deleteCartItem(cartmodel.product.id);
                          }),
                        ),
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

  Widget CheckoutCard()=> Container(
    padding: EdgeInsets.symmetric(
      vertical: 15,
      horizontal: 30,
    ),
    // height: 174,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
      boxShadow: [
        BoxShadow(
          offset: Offset(0, -15),
          blurRadius: 20,
          color: Color(0xFFDADADA).withOpacity(0.15),
        )
      ],
    ),
    child: SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                height: 48,
                width: 100.0,
                decoration: BoxDecoration(
                  color: Color(0xFFF5F6F9),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image(image: AssetImage("assets/images/hng.png")),

              ),
              Spacer(),
              Text("Add Coupon code"),
              const SizedBox(width: 10),
              Icon(
                Icons.arrow_forward_ios,
                size: 12,
                color: default_color,
              )
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text.rich(
                TextSpan(
                  text: "Total:\n",
                  children: [
                    TextSpan(
                      text: "\$${ShopCubit.get(context).cartModel.data.total.toString()}",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 190.0,
                child: buildBtn((){}, 'Check Out')
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
