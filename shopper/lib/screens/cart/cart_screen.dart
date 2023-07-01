import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopper/widgets/loader.dart';

import '../../providers/cart_provider.dart';
import '../../providers/dark_theme_provider.dart';
import '../../providers/product_provider.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    Color theme = context.watch<DarkThemeProvider>().darkTheme
        ? Colors.white
        : Colors.black;
    return SafeArea(
      child: Scaffold(
          body: FutureBuilder(
        future: context.read<CartProvider>().getCart(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Cart (${context.watch<CartProvider>().cartItems.length})',
                        style: TextStyle(
                            color: theme,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '\$ ${context.watch<CartProvider>().totalPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                            color: theme,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        onPressed: () {
                          context.read<CartProvider>().clearCart();
                        },
                        icon: Icon(
                          CarbonIcons.trash_can,
                          color: theme,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: context.read<CartProvider>().cartItems.length,
                    itemBuilder: (context, index) {
                      //final cart = context.watch<CartProvider>().cartItems[index].products![0];
                      // final prod = context
                      //     .watch<ProductProvider>()
                      //     .products
                      //     .firstWhere((element) =>
                      //         element.id ==
                      //         context
                      //             .watch<CartProvider>()
                      //             .cartItems[index]
                      //             .products![0]
                      //             .productId);
                      final prod = context
                          .watch<ProductProvider>()
                          .getProductById(context
                              .watch<CartProvider>()
                              .cartItems[index]
                              .products![0]
                              .productId!);

                      return Padding(
                        padding:
                            const EdgeInsets.only(left: 8, top: 10, right: 8),
                        child: Column(
                          children: [
                            Row(
                              //mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  height: 200,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: NetworkImage(prod.image!),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: Column(
                                    //mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        // prod.title!.substring(0, 20),
                                        prod.title!,
                                        style: TextStyle(
                                            color: theme,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        prod.description!.substring(0, 70),
                                        style: TextStyle(
                                            color: theme,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        '\$ ${prod.price! * context.watch<CartProvider>().cartItems[index].products![0].quantity!}',
                                        style: TextStyle(
                                            color: theme,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all(
                                            CircleBorder(
                                                side:
                                                    BorderSide(color: theme))),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.green),
                                      ),
                                      onPressed: () {
                                        context
                                            .read<CartProvider>()
                                            .increaseQuantity(index);
                                      },
                                      child:
                                          Icon(CarbonIcons.add, color: theme),
                                    ),
                                    Text(
                                        context
                                            .watch<CartProvider>()
                                            .cartItems[index]
                                            .products![0]
                                            .quantity
                                            .toString(),
                                        style: TextStyle(
                                            color: theme,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all(
                                            CircleBorder(
                                                side:
                                                    BorderSide(color: theme))),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.red),
                                      ),
                                      onPressed: () {
                                        context
                                            .read<CartProvider>()
                                            .decreaseQuantity(index);
                                      },
                                      child: Icon(CarbonIcons.subtract,
                                          color: theme),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(height: 10),
                            context.watch<CartProvider>().isLoading
                                ? const Center(
                                    child: CircularProgressIndicator())
                                :
                            IconButton(
                                onPressed: () {
                                  context
                                      .read<CartProvider>()
                                      .deleteCartItem(index);
                                },
                                icon:
                                    Icon(CarbonIcons.trash_can, color: theme)),
                            Divider(thickness: 1, color: theme)
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
          return const CustomLoader(loaderInfo: 'Loading Cart...');
        },
      )
          // Padding(
          //   padding: const EdgeInsets.only(left: 15, top: 10, right: 15),
          //   child: Column(
          //     children: [
          //       Row(
          //         children: [
          //           Text('My Cart',
          //               style: TextStyle(
          //                   color: theme,
          //                   fontSize: 18,
          //                   fontWeight: FontWeight.bold)),
          //           const Spacer(),
          //           Icon(CarbonIcons.delete, color: theme, size: 20),
          //         ],
          //       ),
          //       const Divider(thickness: 1),
          //       Row(
          //         children: [
          //           CircleAvatar(
          //             radius: 25,
          //             backgroundColor: Colors.grey[300],
          //             backgroundImage: const NetworkImage(
          //                 'https://static.generated.photos/vue-static/face-generator/landing/wall/14.jpg'),
          //           ),
          //           const Spacer(),
          //           Text('John Doe',
          //               style: TextStyle(
          //                   color: theme,
          //                   fontSize: 16,
          //                   fontWeight: FontWeight.w500)),
          //         ],
          //       ),
          //       const Divider(thickness: 1),
          //       // swipe to delete list tile
          //       Expanded(
          //         child: ListView.builder(
          //           itemCount: 10,
          //           itemBuilder: (context, index) {
          //             return Dismissible(
          //               key: Key(index.toString()),
          //               direction: DismissDirection.endToStart,
          //               background: Container(
          //                 color: Colors.red,
          //                 child: const Align(
          //                   alignment: Alignment.centerRight,
          //                   child: Padding(
          //                     padding: EdgeInsets.only(right: 20),
          //                     child: Icon(Icons.delete, color: Colors.white),
          //                   ),
          //                 ),
          //               ),
          //               onDismissed: (direction) {
          //                 // remove item from list
          //               },
          //               child: ListTile(
          //                 leading: Container(
          //                   height: 30,
          //                   width: 30,
          //                   decoration: BoxDecoration(
          //                     color: Colors.grey[300],
          //                     borderRadius: BorderRadius.circular(5),
          //                     image: const DecorationImage(
          //                       image: NetworkImage(
          //                           'https://static.generated.photos/vue-static/face-generator/landing/wall/14.jpg'),
          //                       fit: BoxFit.cover,
          //                     ),
          //                   ),
          //                 ),
          //                 title: Text('Product Name',
          //                     style: TextStyle(
          //                         color: theme,
          //                         fontSize: 16,
          //                         fontWeight: FontWeight.w500)),
          //                 subtitle: Text('Product Description',
          //                     style: TextStyle(
          //                         color: Colors.grey[500],
          //                         fontSize: 12,
          //                         fontWeight: FontWeight.w400)),
          //                 trailing: Text('\$ 100',
          //                     style: TextStyle(
          //                         color: theme,
          //                         fontSize: 16,
          //                         fontWeight: FontWeight.w500)),
          //               ),
          //             );
          //           },
          //         ),
          //       )
          //     ],
          //   ),
          // ),
          ),
    );
  }
}
