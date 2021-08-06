import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_app2/Helper/HelperMethods.dart';
import 'package:shop_app2/Helper/compoments.dart';
import 'package:shop_app2/model/user/user_login_data.dart';
import 'package:shop_app2/modeuls/shop_screen/bloc/shopcubit.dart';
import 'package:shop_app2/modeuls/shop_screen/bloc/shopstates.dart';
import 'package:shop_app2/shared/network/remote/dio.dart';
import 'package:shop_app2/shared/pic_image/controller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dio/dio.dart';

class UpdateProfileScreen extends StatefulWidget {
  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  var FormKey = GlobalKey<FormState>();

  TextEditingController nameController = new TextEditingController();

  TextEditingController phoneController = new TextEditingController();

  TextEditingController emailController = new TextEditingController();

  File _image;
  final picker = ImagePicker();
  final ProfileController profilerController = Get.put(ProfileController());

  UserDataModel userDataModel;


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){
          if(state is UserUpdateProfileSucessDataState)
          LinearProgressIndicator(
            backgroundColor: Colors.green,
          );
        },
        builder: (context,state){

       
          
          if(ShopCubit.get(context).profileModel!=null){
            userDataModel = ShopCubit.get(context).profileModel.data;
            nameController.text=userDataModel.name;
            emailController.text=userDataModel.email;
            phoneController.text=userDataModel.phone;
          }

          return buildUpdateProfile(userDataModel,context,state);
    }
    );
  }

  Widget buildUpdateProfile(UserDataModel userDataModel,context,ShopStates state)=>Scaffold(
    appBar: AppBar(
      title : Text('Update Profile'),
    ),

    body:ConditionalBuilder(
      condition: ShopCubit.get(context).profileModel!=null,
      builder:(context)=> SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Form(
          key: FormKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                         child: _image ==null ? Image.network('https://picsum.photos/250?image=9'):Image.file(_image,
                          width: 300
                          ,height: 200,
                          fit: BoxFit.fill,),
                       ),
                   /*    CircleAvatar(radius: 100,
                     backgroundImage:_image==null? NetworkImage(''https://pbs.twimg.com/media/E5tqRxvXMAcrf0r?format=jpg&name=medium''):
                     NetworkImage('https://pbs.twimg.com/media/E5trISKWEAEdIDz?format=jpg&name=medium'),
                     //   backgroundImage:_image==null?NetworkImage('https://twitter.com/iMustafaElazab/photo'):Image.file(_image),
                        child: _image==null?Image(image: NetworkImage('https://pbs.twimg.com/media/E5tqRxvXMAcrf0r?format=jpg&name=medium'),)
                            :CircleAvatar(
                          radius: 80,
                          child: Image.file(_image,fit: BoxFit.contain,),
                        )),*/
                    Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0),),
                      width: 50.0,
                      height: 50.0,
                      child: CircleAvatar(
                        backgroundColor: Colors.grey[300],
                        child: IconButton(
                            icon: Icon(Icons.camera_alt, color:Colors.black54,size: 25,
                            ),
                            color: Colors.blue,
                            onPressed: (){
                              getImage();
                            }
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40.0,
                ),
                defaultTextFormField(
                    controller: nameController,
                    type: TextInputType.text,
                    label: 'Name',
                    validate_message: 'Name must not be empty',
                    prefixIcon: Icons.person),

                SizedBox(height: 30,),
                defaultTextFormField(
                    controller: phoneController,
                    type: TextInputType.phone,
                    label:'Phone',
                    validate_message: 'Phone must not be empty',
                    prefixIcon: Icons.phone),
                SizedBox(height: 30,),
                defaultTextFormField(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    label: 'Email',
                    validate_message: 'Email must not be empty',
                    prefixIcon: Icons.email),
                SizedBox(height: 30,),
                ConditionalBuilder(
                    condition: true,
                    builder: (context) => buildBtn(() {
                      if (FormKey.currentState.validate()) {
                        ShopCubit.get(context).updateUserData(
                          name: nameController.text,
                          phone: phoneController.text,
                          email: emailController.text,
                          image: Image.file(_image).toString(),
                        );
                      }
                    }, 'Update'),
                    fallback: (context) => CircularProgressIndicator()),
              ],
            ),
          ),
        ),
      ),
      fallback: (context)=> Center(child: CircularProgressIndicator()),

    ),
  );

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  /*upLoadImage(File image) async {
    String path = image.path;
    var name = path.substring(path.lastIndexOf("/") + 1, path.length);
    var suffix = name.substring(name.lastIndexOf(".") + 1, name.length);
    FormData formData = new FormData.from({
      "userId": "10000024",
      "file": new UploadFileInfo(new File(path), name,
          contentType: ContentType.parse("image/$suffix"))
    });

    Dio dio = new Dio();
    var respone = await dio.post<String>("/upload", data: formData);
    if (respone.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Image uploaded successfully",
          gravity: ToastGravity.CENTER,
          textColor: Colors.grey);
    }
  }*/
}
