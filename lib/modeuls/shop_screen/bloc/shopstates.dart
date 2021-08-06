import 'package:shop_app2/model/shop/favorites/favorites.dart';

abstract class ShopStates {}

class ShopIntinalState extends ShopStates {}

class ChangeBottomNavgitionBarState extends ShopStates {}

class ShopHomeGetDataLoadingState extends ShopStates {}
class ShopHomeGetDataSucessState extends ShopStates {}
class ShopHomeGetDataErrorState extends ShopStates {}

class ShopCategoriesGetDataSucessState extends ShopStates {}
class ShopCategoriesGetDataErrorState extends ShopStates {}

class ShopChangeFavoritesState extends ShopStates{
  final FavoritesModel model;

  ShopChangeFavoritesState(this.model);
}
class ShopGetFavoritesSucessState extends ShopStates {}
class ShopGetFavoritesErrorState extends ShopStates {}

class GetFavoritesLoadingState extends ShopStates {}
class GetFavoritesSucessState extends ShopStates {}
class GetFavoritesErrorState extends ShopStates {}

class UserGetProfileDataState extends ShopStates {}
class UserUpdateProfileDataState extends ShopStates {}
class UserGetProfileSucessDataState extends ShopStates {}
class UserGetProfileErrorDataState extends ShopStates {}

class UserUpdateProfileSucessDataState extends ShopStates {}
class UserUpdateProfileErrorDataState extends ShopStates {}


class UserAddCartSucessDataState extends ShopStates {}
class UserAddCartErrorDataState extends ShopStates {}

class UserDeleteCartSucessDataState extends ShopStates {}
class UserDeleteCartErrorDataState extends ShopStates{}

class UserCartLoadingDataState extends ShopStates {}
class UserCartSucessDataState extends ShopStates {}
class UserCartErrorDataState extends ShopStates {}

class NotificationLoadingDataState extends ShopStates {}
class NotificationSucessDataState extends ShopStates {}
class NotificationErrorDataState extends ShopStates {}

class SettingLoadingDataState extends ShopStates {}
class SettingSucessDataState extends ShopStates {}
class SettingErrorDataState extends ShopStates {}


class HelpCenterLoadingDataState extends ShopStates {}
class HelpCenterSucessDataState extends ShopStates {}
class HelpCenterErrorDataState extends ShopStates {}


