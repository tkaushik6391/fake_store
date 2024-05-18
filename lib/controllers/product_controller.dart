import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fake_store/models/product.dart';
import 'package:fake_store/service/api_helper.dart';

class ProductController extends GetxController {
  ProductController({required this.apiHelper});

  ApiHelper apiHelper;
  var isLoading = true.obs;
  var productList = <Product>[].obs;
  var filteredProductList = <Product>[].obs;
  List<Product> cart = <Product>[].obs;
  var categories = <String>[].obs;
  var selectedCategory = ''.obs;
  var searchText = ''.obs;
  int productLimit = 5;
  int productLimitCounter = 5;
  int totalProductCount = 0;

  @override
  void onInit() {
    super.onInit();

    fetchProducts();
    fetchProductsByLimit();
    fetchCategories();
    loadCartFromStorage();
  }

  void fetchProducts() async {
    var products = await apiHelper.fetchProducts();
    if (products.isNotEmpty) {
      totalProductCount = products.length;
    }
  }

  void fetchProductsByLimit({bool isLoadingMore = false}) async {
    try {
      isLoading(true);
      var products = await apiHelper.fetchProductsByLimit(limit: productLimit);
      if (products.isNotEmpty) {
        productList.clear();
        if (isLoadingMore) {
          productList.addAll(products);
        } else {
          productList.assignAll(products);
        }
        filteredProductList.assignAll(productList);
      }
    } finally {
      isLoading(false);
    }
  }

  void fetchCategories() async {
    try {
      var fetchedCategories = await apiHelper.fetchCategories();
      if (fetchedCategories.isNotEmpty) {
        categories.assignAll(fetchedCategories);
      }
    } catch (e) {
      print(e);
    }
  }

  void filterByCategory(String category) {
    selectedCategory.value = category;
    if (category.isEmpty) {
      filteredProductList.assignAll(productList);
    } else {
      filteredProductList
          .assignAll(productList.where((p) => p.category == category).toList());
    }
  }

  void searchProducts(String query) {
    searchText.value = query;
    if (query.isEmpty) {
      filteredProductList.assignAll(productList);
    } else {
      filteredProductList.assignAll(productList
          .where((p) => p.title.toLowerCase().contains(query.toLowerCase()))
          .toList());
    }
  }

  void loadCartFromStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? cartItems = prefs.getStringList('cart') ?? [];

// Check for any blank values and remove them
    cartItems.removeWhere((item) => item.isEmpty || item == "null");

// Save the cleaned list back to SharedPreferences if modified
    if (cartItems.contains('')) {
      await prefs.setStringList('cart', cartItems);
    }
    if (cartItems != null) {
      cart.assignAll(
          cartItems.map((item) => Product.fromJson(jsonDecode(item))).toList());
    }
  }

  void loadMoreProducts() {
    productLimit += productLimitCounter;
    fetchProductsByLimit(isLoadingMore: true);
  }
}
