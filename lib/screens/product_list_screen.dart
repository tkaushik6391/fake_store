import 'package:fake_store/app_tools.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fake_store/controllers/product_controller.dart';
import 'package:fake_store/screens/cart_screen.dart';
import 'package:fake_store/screens/product_detail_screen.dart';

class ProductListScreen extends GetView<ProductController> {
  const ProductListScreen({super.key});
  static const String id = '/ProductListScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          return controller.searchText.value.isEmpty
              ? const Text('Products')
              : TextField(
                  onChanged: controller.searchProducts,
                  autofocus: true,
                  decoration: const InputDecoration(
                    hintText: 'Search products...',
                    border: InputBorder.none,
                  ),
                );
        }),
        actions: [
          IconButton(
            icon: Icon(controller.searchText.value.isEmpty ? Icons.search : Icons.close),
            onPressed: () {
              if (controller.searchText.value.isEmpty) {
                controller.searchText.value = ' ';
              } else {
                controller.searchText.value = '';
                controller.searchProducts('');
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => Get.to(CartScreen()),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: controller.categories.map((category) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FilterChip(
                        label: Text(category),
                        selected: controller.selectedCategory.value == category,
                        onSelected: (isSelected) {
                          if (isSelected) {
                            controller.filterByCategory(category);
                          } else {
                            controller.filterByCategory('');
                          }
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.filteredProductList.length,
                  itemBuilder: (context, index) {
                    final product = controller.filteredProductList[index];
                    return Container(
                      decoration: listItemDecoration,
                      margin: const EdgeInsets.all(8),
                      child: ListTile(
                        title: Text(product.title),
                        subtitle: Text('\$${product.price}'),
                        leading: Image.network(product.image, width: 50, height: 50),
                        onTap: () => Get.to(ProductDetailScreen(product: product)),
                      ),
                    );
                  },
                ),
              ),
                Visibility(
                  visible: controller.isLoading.value,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  ),
                ),
              Visibility(
                visible: controller.productList.length < controller.totalProductCount,
                child: ElevatedButton(
                  onPressed: controller.loadMoreProducts,
                  child: const Text('Load More'),
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}
