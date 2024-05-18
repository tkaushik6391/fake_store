import 'dart:convert';
import 'package:fake_store/models/product.dart';
import 'package:fake_store/service/api_extention_utils.dart';
import 'package:get/get.dart';

class ApiHelper extends GetConnect {

  ApiHelper() {
    httpClient.baseUrl = "https://fakestoreapi.com";
    httpClient.timeout = const Duration(seconds: 40);
    httpClient.maxAuthRetries = 3;
  }

  Future<String> login(String username, String password) async {
    final response = await (() =>
        post("/auth/login", 
        jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
        )).withRetries();
    
    
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.bodyString ?? "");
      return body['token'];
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<List<Product>> fetchProducts() async {

    final response = await (() => get(
          '/products',
        )).withRetries();
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.bodyString ?? "");
      return body.map((dynamic item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<List<Product>> fetchProductsByLimit(
      {int limit = 5}) async {

        final response = await (() => get(
          '/products?limit=$limit',
        )).withRetries();
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.bodyString ?? "");
      return body.map((dynamic item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<List<String>> fetchCategories() async {
    final response = await (() => get(
          '/products/categories',
        )).withRetries();
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.bodyString ?? "");
      return List<String>.from(body);
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<List<Product>> fetchProductsByCategory(String category) async {

        final response = await (() => get(
          '/products/category/$category',
        )).withRetries();
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.bodyString ?? "");
      return body.map((dynamic item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load products by category');
    }
  }
}
