import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/product_provider.dart';
import '../../widgets/product_tile.dart';

class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductProvider>();
    final provider2 = context.read<ProductProvider>();
    return Scaffold(
        appBar: AppBar(
          title: const Text('All Products'),
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: provider2.fetchProducts(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: provider.products.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemBuilder: (context, index) {
                          return ChangeNotifierProvider.value(
                              value: provider.products[index],
                              child: const productTile());
                        },
                      ),
                    ],
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            })
        //     SingleChildScrollView(
        //   physics: const BouncingScrollPhysics(),
        //   child: Column(
        //     children: [
        //       GridView.builder(
        //         shrinkWrap: true,
        //         physics: const NeverScrollableScrollPhysics(),
        //         itemCount: provider.products.length,
        //         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //           crossAxisCount: 2,
        //           childAspectRatio: 0.7,
        //           crossAxisSpacing: 10,
        //           mainAxisSpacing: 10,
        //         ),
        //         itemBuilder: (context, index) {
        //           return ChangeNotifierProvider.value(
        //               value: provider.products[index],
        //               child: const productTile());
        //         },
        //       ),
        //     ],
        //   ),
        // ),
        );
  }
}
