import 'dart:ui';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:shop_app2/Helper/HelperMethods.dart';
import 'package:shop_app2/modeuls/user_screen/login_screen/login_screen.dart';
import 'package:shop_app2/shared/network/local/sharedpreferenceHelper.dart';
import 'package:shop_app2/shared/styles/color.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel{
  final String title;
  final String image;
  final String body;

  BoardingModel({
   @required this.title,
   @required this.image,
   @required this.body,

  });

}


class onBoardingScreen extends StatefulWidget {

  @override
  _onBoardingScreenState createState() => _onBoardingScreenState();
}

class _onBoardingScreenState extends State<onBoardingScreen> {
  var boardController=PageController();

  List<BoardingModel> bording_model=[
    BoardingModel(title: 'SHOPIA', image: 'assets/images/splash_1.png', body: ''' Welcome to SHOPIA. Let's Shop! '''),
    BoardingModel(title: 'SHOPIA', image: 'assets/images/splash_2.png', body: ''' Welcome to SHOPIA. Let's Shop! '''),
    BoardingModel(title: 'SHOPIA', image: 'assets/images/splash_3.png', body: ''' Welcome to SHOPIA. Let's Shop! '''),
  ];
     var isLast=false;
     
     void onSubmit(){
       CacheHelper.saveData(key: 'onBoarding', value: true).then((value){

         if(value){
           Navigate_Finsih(context, LoginScreen());
         }
       });
     }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(itemBuilder: (context,index)=>buildonBorder(bording_model[index]),
                itemCount: bording_model.length,
                controller: boardController,
                physics: BouncingScrollPhysics(),
                onPageChanged: (index){
                if(index==bording_model.length -1){
                  setState(() {
                    isLast = true;
                  });
                }else{
                  setState(() {
                    isLast=false;
                  });
                }
                },
              ),
            ),
            SizedBox(height: 50.0,),
            Row(
              children: [
                SmoothPageIndicator(controller: boardController, count: bording_model.length,
                effect: ExpandingDotsEffect(
                  dotWidth: 10.0,
                  dotColor: Colors.grey,
                  dotHeight: 10.0,
                  spacing: 5.0,
                  expansionFactor: 2,
                  activeDotColor: default_color,
                ),),
                Spacer(),
                FloatingActionButton(onPressed: (){
                  if(isLast){
                    onSubmit();
                  }
                 boardController.nextPage(duration: Duration(milliseconds: 750), curve: Curves.fastLinearToSlowEaseIn);
                },
                child: Icon(Icons.arrow_forward_ios_rounded),),
                SizedBox(height: 20.0,)
              ],
            )
          ],
        ),
      )
    );
  }
}
