// ignore_for_file: prefer_final_fields, unnecessary_type_check, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:shopper/models/product_model.dart';

import '../services/dio_repo.dart';

class ProductProvider with ChangeNotifier {
  ProductProvider() {
    fetchProducts();
    fetchCategories();
    //getProductsByCategory(selectedCategoryIndex);
  }

  List<Product> _products = [];
  List<Product> get products => _products;
  List<Product> _searchList = [];
  //List<Product> _productsByCategory = [];
  String _errorMessage = '';
  String _selectedCategoryIndex = '';

  List<String> _categories = [];
  List<String> get categories => _categories;
  //List<Product> get productsByCategory => _productsByCategory;
  List<Product> get searchList => _searchList;
  String get errorMessage => _errorMessage;
  String get selectedCategoryIndex => _selectedCategoryIndex;

  // set selected category index
  void setSelectedCategory(String category) {
    _selectedCategoryIndex = category;
    notifyListeners();
  }

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

  // get products by category
  Future<List<Product>> getProductsByCategory(String category) async {
    final data = await DataRepository().fetchProductsByCategory(category);
    if (data is List<Product>) {
      //_products = data;
      _products = data;
      notifyListeners();
      return _products;
    } else {
      throw Exception('Failed to load products');
    }
  }

  // search products
  List<Product> searchProducts(String query) {
    _searchList = _products
        .where((prod) =>
            prod.title!.toLowerCase().contains(query.toLowerCase()) ||
            prod.description!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return _searchList;
  }
}
