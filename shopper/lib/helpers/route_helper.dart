import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:shopper/screens/home/all_products_screen.dart';
import 'package:shopper/screens/home/home.dart';
import 'package:shopper/screens/home/prdt_details_screen.dart';

import '../screens/categories/category_products_screen.dart';

class RouteHelper {
  static final FluroRouter router = FluroRouter();

  static String home = '/home';
  static String allProducts = '/all-products';
  static String productDetails = '/product-details';
  static String categoryProductsScreen = '/category-products-screen';

  static final Handler _homeHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
          const Home());
  static final Handler _allProductsHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
          const AllProductsScreen());
  static final Handler _productDetailsHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
          const ProductDetail());
  static final Handler _categoryProductsHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
          const CategoryScreenProducts());

  static void setupRouter() {
    router.define(home,
        handler: _homeHandler, transitionType: TransitionType.fadeIn);
    router.define(allProducts,
        handler: _allProductsHandler, transitionType: TransitionType.fadeIn);
    router.define(productDetails,
        handler: _productDetailsHandler, transitionType: TransitionType.fadeIn);
    router.define(categoryProductsScreen,
        handler: _categoryProductsHandler,
        transitionType: TransitionType.fadeIn);
  }
}
