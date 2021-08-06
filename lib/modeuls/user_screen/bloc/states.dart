import 'package:shop_app2/model/user/user_login_data.dart';

abstract class UserStates {}

class UserLoginIntinalState extends UserStates {}

class UserLoginLoadingState extends UserStates {}

class UserLoginSucessState extends UserStates {
  final UserModel userModel;

  UserLoginSucessState(this.userModel);
}

class UserLoginErrorState extends UserStates {
  final String  error;

  UserLoginErrorState(this.error);
}
class UserShowPasswordState extends UserStates {}
class UserRegisterLoadingState extends UserStates {}

class UserRegisterSucessState extends UserStates {
  final UserModel userModel;

  UserRegisterSucessState(this.userModel);
}

class UserRegisterErrorState extends UserStates {

}






