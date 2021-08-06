import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app2/Helper/HelperMethods.dart';
import 'package:shop_app2/Helper/compoments.dart';
import 'package:shop_app2/model/help_center/help_center_model.dart';
import 'package:shop_app2/model/shop/cart/cartmodel.dart';
import 'package:shop_app2/model/shop/categories/categories_model.dart';
import 'package:shop_app2/model/shop/favorites/favorites.dart';
import 'package:shop_app2/model/shop/favorites/favoritesmodel.dart';
import 'package:shop_app2/model/shop/home_shop_model.dart';
import 'package:shop_app2/model/shop/notification/notification_model.dart';
import 'package:shop_app2/model/shop/settings/setting_model.dart';
import 'package:shop_app2/model/user/user_login_data.dart';
import 'package:shop_app2/modeuls/shop_screen/bloc/shopstates.dart';
import 'package:shop_app2/modeuls/shop_screen/category/categories_screen.dart';
import 'package:shop_app2/modeuls/shop_screen/favouite/favourite_screen.dart';
import 'package:shop_app2/modeuls/shop_screen/home/home_screen.dart';
import 'package:shop_app2/modeuls/shop_screen/profile/profile_screen.dart';
import 'package:shop_app2/shared/network/remote/dio.dart';
import 'package:shop_app2/shared/network/remote/end_points.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopIntinalState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int current_index = 0;
  List<Widget> screens = [
    HomeScreen(),
    CategoriesScreen(),
    FavouriteScreen(),
    ProfileScreen(),
  ];

  List<BottomNavigationBarItem> bottomItem = [
    BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.category_outlined), label: 'Categories'),
    BottomNavigationBarItem(icon: Icon(Icons.favorite_outline), label: 'Favourite'),
    BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
  ];

  void changebottomnavbar(int index) {
    current_index = index;
    emit(ChangeBottomNavgitionBarState());
  }

  HomeModel shopModel;
  String token = TOKEN;
  Map<int, bool> favourite = {};

  void getHomeData() {
    emit(ShopHomeGetDataLoadingState());
    DioHelper.getData(url: HOMEDATA, authorization: token).then((value) {
      shopModel = HomeModel.fromJson(value.data);
      if (shopModel.status) {
        toast(message: 'done get Data', color: Colors.green);
        shopModel.data.products.forEach((element) {
          favourite.addAll({element.id: element.inFavorites});
        });
        print(favourite);
        print(shopModel.data.products);
        print(token);
        emit(ShopHomeGetDataSucessState());
      } else {
        toast(message: 'Failed get Data', color: Colors.red);
      }
    }).catchError((error) {
      print(error);
      emit(ShopHomeGetDataErrorState());
    });
  }

  CategoriesModel categoriesModel;

  void getCategoriesData() {
    DioHelper.getData(url: GET_CATEGORIES).then((value) {
      categoriesModel = CategoriesModel.FromJson(value.data);
      if (categoriesModel.status) {
        print(categoriesModel.data);
        emit(ShopCategoriesGetDataSucessState());
      }
    }).catchError((error) {
      print(error);
      emit(ShopCategoriesGetDataErrorState());
    });
  }

  FavoritesModel favoritesModel;

  void changeFavorites(int modelId) {
    favourite[modelId] = !favourite[modelId];

    emit(ShopChangeFavoritesState(favoritesModel));
    DioHelper.postData(
            url: FAVORITES, data: {'product_id': modelId}, authorization: TOKEN)
        .then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);

      if (!favoritesModel.status) {
        favourite[modelId] = !favourite[modelId];
      } else {
        getFavoritesProduct();
      }
      emit(ShopGetFavoritesSucessState());
    }).catchError((error) {
      favourite[modelId] = !favourite[modelId];
      print(error.toString());
      emit(ShopGetFavoritesErrorState());
    });
  }

  FavouritesModel favouritesModel;

  void getFavoritesProduct() {

    emit(GetFavoritesLoadingState());
    DioHelper.getData(url: FAVORITES, authorization: TOKEN).then((value) {

      favouritesModel = FavouritesModel.fromJson(value.data);
      if(favouritesModel.data.data!=null)
      emit(GetFavoritesSucessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetFavoritesErrorState());
    });
  }

  UserModel profileModel;

  void getUserData() {
    emit(UserGetProfileDataState());
    DioHelper.getData(url: PROFILE, authorization: TOKEN).then((value) {
      profileModel = UserModel.fromJson(value.data);
      if (profileModel.status) print(profileModel.data.email.toString());
      emit(UserGetProfileSucessDataState());
    }).catchError((error) {
      print(error.toString());
      emit(UserGetProfileErrorDataState());
    });
  }

  UserModel updateModel;

  void updateUserData({
    @required String name,
    @required String phone,
    @required String email,
    String image,
  }) {
    DioHelper.putData(url: UPDATEUSER, authorization: TOKEN, data: {
      'name': name,
      'phone': phone,
      'email': email,
      'image': image,
    }).then((value) {
      updateModel = UserModel.fromJson(value.data);
      if (updateModel.status) print(updateModel.data.name);
      toast(message: updateModel.message, color: Colors.green);
      emit(UserUpdateProfileSucessDataState());
      getUserData();
    }).catchError((error) {
      print(error.toString());
      toast(message: updateModel.message, color: Colors.red);
      emit(UserUpdateProfileErrorDataState());
    });
  }

  CartModel cartModel;

  void addCartItem(int id) {
    DioHelper.postData(
        url: CART,
        authorization: TOKEN,
        data: {'product_id': id}).then((value) {
      cartModel = CartModel.fromJson(value.data);
      if (cartModel.status) {
        print('done add to cart ');
        emit(UserAddCartSucessDataState());
        getCartItem();
      }
    }).catchError((error) {
      print("Cart Error${error}");
      emit(UserAddCartErrorDataState());
    });
  }

  dynamic sum = 0;
  void getCartItem() async{
    emit(UserCartLoadingDataState());
  await DioHelper.getData(url: CART, authorization: TOKEN).then((value) {
      cartModel = CartModel.fromJson(value.data);
      if (cartModel.status) {
        print('get cart done');
        print(cartModel.data.cartItems.length);
        cartModel.data.cartItems.forEach((element) {
          print(element.product.price);
        });
        getTotalCart();
        emit(UserCartSucessDataState());

      }
    }).catchError((error) {
      print("Cart Error${error}");
      emit(UserCartErrorDataState());
    });


  }

  void getTotalCart() {
    List<CartItems> cartItems = cartModel.data.cartItems;
    for (var i = 0; i < cartItems.length; i++) {
      sum += cartItems[i].product.price;
    }
    print("Sum : ${sum}");
  }

  NotifiyModel notificationModel;
  void getNotification() {
    emit(NotificationLoadingDataState());
    DioHelper.getData(url: NOTIFICATIONS, authorization: TOKEN).then((value) {
      notificationModel = NotifiyModel.fromJson(value.data);
      if(notificationModel.status)
        print('get cart done');
        print(cartModel.data.cartItems.length);
        emit(NotificationSucessDataState());

    }).catchError((error) {
      print("Notification Error${error}");
      emit(NotificationErrorDataState());
    });


  }


  void deleteCartItem(int id) {
    DioHelper.postData(
        url: CART,
        authorization: TOKEN,
        data: {'product_id': id}).then((value) {
      cartModel = CartModel.fromJson(value.data);
      if (cartModel.status) {
        print('done delete item  ');
        emit(UserDeleteCartSucessDataState());
        getCartItem();
      }
    }).catchError((error) {
      print("Cart Error${error}");
      emit(UserDeleteCartErrorDataState());
    });
  }


  SettingModel settingModel;
  void getSettingData() {
    emit(SettingLoadingDataState());
    DioHelper.getData(url: SETTINGS).then((value) {
      settingModel = SettingModel.fromJson(value.data);
      if (settingModel.status) {
        print("the settingModel data ${settingModel.data}");
        emit(SettingSucessDataState());
      }
    }).catchError((error) {
      print("setting_error${error}");
      emit(SettingErrorDataState());
    });
  }


  HelpCenterModel helpCenterModel;
  void getHelpCenterData() {
    emit(HelpCenterLoadingDataState());
    DioHelper.getData(url: FAQS).then((value) {
      helpCenterModel = HelpCenterModel.fromJson(value.data);
      if (helpCenterModel.status) {
        print(helpCenterModel.status);
        print("the helpCenterModel data ${helpCenterModel.data}");
        emit(HelpCenterSucessDataState());
      }
    }).catchError((error) {
      print("setting_error${error}");
      emit(HelpCenterErrorDataState());
    });
  }

}
