// ignore_for_file: unnecessary_type_check

import 'package:flutter/material.dart';
import 'package:shopper/models/product_model.dart';
import 'package:shopper/providers/product_provider.dart';
import 'package:shopper/services/dio_repo.dart';

import '../models/cart_models.dart';

class CartProvider with ChangeNotifier {
  // list of products in the cart
  List<Cart> _cartItems = [];
  bool _isLoading = false;

  // getter for the cart items
  List<Cart> get cartItems => _cartItems;
  bool get isLoading => _isLoading;

  // product provider class
  ProductProvider _productProvider = ProductProvider();

  double get totalPrice {
    double _total = 0.0;
    _cartItems.forEach((element) {
      element.products!.forEach((e) {
        _total +=
            e.quantity! * _productProvider.getProductById(e.productId!).price!;
      });
    });
    return _total;
  }

  // method to calculate the total price of items in the cart
  // double totalPrice (double price){
  //   //_total = 0.0;

  //   _cartItems.forEach((element) {
  //     element.products!.forEach((e) {
  //       _total += e.quantity! * e.price!;
  //     });
  //   });
  //   return _total;
  // }

  // method to add items to the cart
  Future<void> addToCart(Product data) async {
    await DataRepository().postToCart(Cart(
      userId: 1,
      date: DateTime.now().toString(),
      products: [
        Products(productId: data.id, quantity: 1),
      ],
    ));
    notifyListeners();
  }

  // method to get items from the cart
  Future<List<Cart>> getCart() async {
    var mydata = await DataRepository().getCartItems();
    if (mydata is List<Cart>) {
      _cartItems = mydata;
    }
    print(_cartItems.length);
    notifyListeners();
    return _cartItems;
  }

  // delete an item from the cart
  Future<void> deleteCartItem(int id) async {
    _isLoading = true;
    print('Cart item deleted');
    await DataRepository().deleteCartItem(id);
    print('Cart item deleted 22222');
    _isLoading = false;
    notifyListeners();
  }

  // clear cart  
  Future<void> clearCart() async {
    print('Cart cleared 11111');
    await DataRepository().deleteAllCartItems();
    print('Cart cleared  22222');
    notifyListeners();
  }

  // increase quantity when the add button is pressed
  Future<void> increaseQuantity(int index) async {
    print('Before  ${_cartItems[index].products![0].quantity!}');
    var copy = _cartItems[index].products![0].quantity;
    var newCopy = copy! + 1;
    _cartItems[index].products?[0].quantity = newCopy;
    await DataRepository().postToCart(
      Cart(
        userId: _cartItems[index].userId,
        date: DateTime.now().toString(),
        products: [
          Products(
              productId: _cartItems[index].products![0].productId,
              quantity: newCopy),
        ],
      ),
    );
    print('After  ${_cartItems[index].products![0].quantity}');
    notifyListeners();
  }

  // decrease quantity
  void decreaseQuantity(int index) {
    if (_cartItems[index].products![0].quantity! > 1) {
      var copy = _cartItems[index].products![0].quantity;
      var newCopy = copy! - 1;
      _cartItems[index].products?[0].quantity = newCopy;
    } else {
      return;
    }
    notifyListeners();
  }
}
