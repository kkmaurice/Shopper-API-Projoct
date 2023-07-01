import 'package:dio/dio.dart';
import 'package:shopper/models/product_model.dart';
import 'package:shopper/utils/app_constants.dart';

import '../models/cart_models.dart';

class DataRepository {
  // create an instance of dio
  final Dio _dio = Dio();
  // method to fetch data from the api and return a list of products
  Future<List<Product>> fetchProducts() async {
    try {
      final response = await _dio.get(AppConstants.baseUrl);
      final data = response.data as List;
      final products = data.map((e) => Product.fromJson(e)).toList();
      return products;
    } catch (e) {
      throw Exception(e);
    }
  }

  // method to fetch categories and return a list of categories
  Future<List<String>> fetchCategories() async {
    try {
      final response = await _dio.get(AppConstants.categoriesUrl);
      final data = response.data as List;
      final categories = data.map((e) => e.toString()).toList();
      return categories;
    } catch (e) {
      throw Exception(e);
    }
  }

  // get products by category
  Future<List<Product>> fetchProductsByCategory(String category) async {
    try {
      final response =
          await _dio.get('${AppConstants.baseUrl}/category/$category');
      final data = response.data as List;
      final products = data.map((e) => Product.fromJson(e)).toList();
      final categoryProducts =
          products.where((element) => element.category == category).toList();
      return categoryProducts;
    } catch (e) {
      throw Exception(e);
    }
  }

  // post to cart
  Future<void> postToCart(Cart cartItem) async {
    try {
      await _dio.post(AppConstants.cartUrl, data: cartItem.toJson());
    } catch (e) {
      throw Exception(e);
    }
  }

  // get cart items
  Future<List<Cart>> getCartItems() async {
    try {
      final response = await _dio.get(AppConstants.cartUrl);
      final data = response.data as List;
      final cartItems = data.map((e) => Cart.fromJson(e)).toList();

      return cartItems;
    } catch (e) {
    throw Exception(e);
    }
  }

  // delete cart item
  Future<void> deleteCartItem(int id) async {
    try {
      await _dio.delete('${AppConstants.cartUrl}/$id');
    } catch (e) {
      throw Exception(e);
    }
  }

  // delete all cart items
  Future<void> deleteAllCartItems() async {
    try {
      await _dio.delete(AppConstants.cartUrl);
    } catch (e) {
      throw Exception(e);
    }
  }
}
