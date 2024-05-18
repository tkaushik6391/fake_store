import 'package:fake_store/controllers/login_controller.dart';
import 'package:get/get.dart';
import '../../../service/api_helper.dart';

class HomeBinding extends Bindings {
  HomeBinding();

  @override
  void dependencies() {
    Get.put(ApiHelper());
    Get.put(LoginController(apiHelper: Get.find()));
  }
}
