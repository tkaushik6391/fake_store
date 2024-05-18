// const Transition transition = Transition.rightToLeftWithFade;
import 'package:fake_store/bindings/login_binding.dart';
import 'package:fake_store/bindings/product_binding.dart';
import 'package:fake_store/screens/login_screen.dart';
import 'package:fake_store/screens/product_list_screen.dart';
import 'package:get/get.dart';

const Duration transitionDuration = Duration(milliseconds: 200);

class AppRoutes {
  static const initial = LoginScreen.id;

  static final routes = [
    
    GetPage(
        name: LoginScreen.id,
        page: () => const LoginScreen(),
        binding: LoginBinding()),

    GetPage(
        name: ProductListScreen.id,
        page: () => const ProductListScreen(),
        binding: ProductBinding()),

  ];
}