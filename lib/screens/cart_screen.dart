import 'package:fake_store/cart_service.dart';
import 'package:fake_store/models/product.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Product> cartItems = [];
  final CartService cartService = CartService();

  @override
  void initState() {
    super.initState();
    loadCartItems();
  }

  Future<void> loadCartItems() async {
    List<Product> items = await cartService.getCartItems();
    setState(() {
      cartItems = items;
    });
  }

  Future<void> removeItemFromCart(Product product) async {
    await cartService.removeItemFromCart(product);
    loadCartItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(cartItems[index].title),
            subtitle: Text('\$${cartItems[index].price}'),
            leading:
                Image.network(cartItems[index].image, width: 50, height: 50),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => removeItemFromCart(cartItems[index]),
            ),
          );
        },
      ),
    );
  }
}
