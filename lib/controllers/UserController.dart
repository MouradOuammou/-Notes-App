import 'package:get/get.dart';

import '../models/user.dart';

class UserController extends GetxController {
  final Rx<UserModel> _userModel = UserModel(id: '', name: '', email: '').obs;

  UserModel get user => _userModel.value;
  set user(UserModel value) => _userModel.value = value;
  void clear() {
    _userModel.value = UserModel(id: '', name: '', email: '');
  }
}
