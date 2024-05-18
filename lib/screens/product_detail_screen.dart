import 'package:fake_store/app_tools.dart';
import 'package:fake_store/cart_service.dart';
import 'package:fake_store/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fake_store/models/product.dart';

class ProductDetailScreen extends GetView<ProductController> {
  final Product product;
  static const String id = '/ProductDetailScreen';
  

  ProductDetailScreen({super.key, required this.product});
  final CartService cartService = CartService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: listItemDecoration,
          child: Column(
            children: [
              Image.network(product.image, height: 200),
              const SizedBox(height: 20),
              Text(product.title, style: const TextStyle(fontSize: 24)),
              const SizedBox(height: 10),
              Text('\$${product.price}', style: const TextStyle(fontSize: 20)),
              const SizedBox(height: 10),
              Text(product.description),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async{
                  await cartService.addItemToCart(product);
                  Get.snackbar('Success', 'Product added to cart');
                },
                child: const Text('Add to Cart'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
