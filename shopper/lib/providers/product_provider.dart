// ignore_for_file: prefer_final_fields, unnecessary_type_check, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:shopper/models/product_model.dart';

import '../services/dio_repo.dart';

class ProductProvider with ChangeNotifier {
  ProductProvider() {
    fetchProducts();
    fetchCategories();
  }

  List<Product> _products = [];
  List<Product> get products => _products;
  String _errorMessage = '';

  List<String> _categories = [];
  List<String> get categories => _categories;
  String get errorMessage => _errorMessage;

  // get product by id
  Product getProductById(int id) {
    return _products.firstWhere((prod) => prod.id == id);
  }

  // fetch products
  Future<List<Product>> fetchProducts() async {
    final data = await DataRepository().fetchProducts();
    if (data is List<Product>) {
      _products = data;
      //print(_products[2].description);
      notifyListeners();
      return _products;
    } else {
      _errorMessage = 'Failed to load products';
      notifyListeners();
      throw Exception('Failed to load products');
    }
  }

  // fetch categories
  Future<List<String>> fetchCategories() async {
    final data = await DataRepository().fetchCategories();
    if (data is List<String>) {
      _categories = data;
      notifyListeners();
      return _categories;
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
