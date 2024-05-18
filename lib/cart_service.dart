import 'dart:convert';
import 'package:fake_store/models/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartService {
  Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token'); 
  }

  Future<void> addItemToCart(Product product) async {
    String? token = await _getToken();
    if (token == null) return;

    List<Product> cart = await _getCart(token);
    cart.add(product);
    await _saveCart(token, cart);
  }

  Future<void> removeItemFromCart(Product product) async {
    String? token = await _getToken();
    if (token == null) return;

    List<Product> cart = await _getCart(token);
    cart.removeWhere((item) => item.id == product.id);
    await _saveCart(token, cart);
  }

  Future<List<Product>> getCartItems() async {
    String? token = await _getToken();
    if (token == null) return [];

    return await _getCart(token);
  }

  Future<void> clearCart() async {
    String? token = await _getToken();
    if (token == null) return;

    await _saveCart(token, []);
  }

  Future<List<Product>> _getCart(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cartJson = prefs.getString('cart_$token');
    if (cartJson != null) {
      List<dynamic> cartList = jsonDecode(cartJson);
      return cartList.map((item) => Product.fromJson(item)).toList();
    }
    return [];
  }

  Future<void> _saveCart(String token, List<Product> cart) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String cartJson = jsonEncode(cart.map((item) => item.toJson()).toList());
    await prefs.setString('cart_$token', cartJson);
  }
}