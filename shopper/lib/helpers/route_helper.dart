import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:shopper/screens/all_products_screen.dart';
import 'package:shopper/screens/home.dart';
import 'package:shopper/screens/prdt_details_screen.dart';

class RouteHelper {
  static final FluroRouter router = FluroRouter();

  static String home = '/home';
  static String allProducts = '/all-products';
  static String productDetails = '/product-details';

  static final Handler _homeHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
          const Home());
  static final Handler _allProductsHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
          const AllProductsScreen());
  static final Handler _productDetailsHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
          const ProductDetail());

  static void setupRouter() {
    router.define(home,
        handler: _homeHandler, transitionType: TransitionType.fadeIn);
    router.define(allProducts,
        handler: _allProductsHandler, transitionType: TransitionType.fadeIn);
    router.define(productDetails,
        handler: _productDetailsHandler, transitionType: TransitionType.fadeIn);
  }
}
