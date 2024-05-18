import 'package:fake_store/controllers/product_controller.dart';
import 'package:fake_store/service/api_helper.dart';
import 'package:get/get.dart';

class ProductBinding extends Bindings {
  ProductBinding();

  @override
  void dependencies() {
    Get.put(ApiHelper());
    Get.put(ProductController(apiHelper: Get.find()));
  }
}