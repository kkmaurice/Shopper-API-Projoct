import 'package:badges/badges.dart' as bg;
import 'package:flutter/material.dart';

class ShoppingCartIcon extends StatelessWidget {
  final double? iconSize;
  const ShoppingCartIcon({Key? key, this.iconSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final cartProvider = Provider.of<Cart>(context, listen: true);

    return IconButton(
      onPressed: () {
//Navigator.of(context).pushNamed(CartScreen.routeName);
      },
      icon: bg.Badge(
        badgeStyle: bg.BadgeStyle(
          padding: const EdgeInsets.all(5),
          borderRadius: BorderRadius.circular(10),
          badgeColor: Colors.redAccent,
          elevation: 1,
        ),
        //elevation: 1,
        //badgeColor: kBrandAccent,
        showBadge: true,
        //showBadge: cartProvider.cartItems.isNotEmpty,
        badgeContent: Text(
          //cartProvider.cartItems.length.toString(),
          2.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        child: const Icon(
          Icons.shopping_cart_outlined,
        ),
      ),
    );
  }
}
