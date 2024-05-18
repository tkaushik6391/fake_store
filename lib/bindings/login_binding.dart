import 'package:fake_store/controllers/login_controller.dart';
import 'package:fake_store/service/api_helper.dart';
import 'package:get/get.dart';

class LoginBinding extends Bindings {
  LoginBinding();

  @override
  void dependencies() {
    Get.put(ApiHelper());
    Get.put(LoginController(apiHelper: Get.find()));
  }
}