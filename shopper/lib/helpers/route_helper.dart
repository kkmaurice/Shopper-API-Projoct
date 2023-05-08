import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:shopper/screens/all_products_screen.dart';
import 'package:shopper/screens/home.dart';
import 'package:shopper/widgets/btm_nav_bar.dart';

class RouteHelper {
  static final FluroRouter router = FluroRouter();

  // static String base = '/';
  static String home = '/home';
  static String allProducts = '/all-products';

  // static String getBaseRoute() => base;

  static final Handler _homeHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
          const Home());
  static final Handler _allProductsHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
          const AllProductsScreen());

  static void setupRouter() {
    // router.define(base,
    //     handler: _baseHandler, transitionType: TransitionType.fadeIn);
    router.define(home,
        handler: _homeHandler, transitionType: TransitionType.fadeIn);
    router.define(allProducts,
        handler: _allProductsHandler, transitionType: TransitionType.fadeIn);
  }
}
