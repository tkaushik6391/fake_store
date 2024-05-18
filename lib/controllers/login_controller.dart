import 'package:fake_store/screens/product_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fake_store/service/api_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  LoginController({required this.apiHelper});

  ApiHelper apiHelper;
  var isLoading = false.obs;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> login() async {
    isLoading(true);
    try {
      String username = usernameController.text.trim();
      String password = passwordController.text.trim();
      String token = await apiHelper.login(username, password);
      
      // Save token to shared preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);

      // Navigate to Product List Screen
      Get.offAllNamed(ProductListScreen.id);
    } catch (e) {
      Get.snackbar('Error', 'Login failed. Please try again.');
    } finally {
      isLoading(false);
    }
  }
}
