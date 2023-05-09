// ignore_for_file: sized_box_for_whitespace, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopper/widgets/cart_icon.dart';
import 'package:shopper/widgets/loader.dart';
import 'package:shopper/widgets/search_bar_widget.dart';

import '../providers/product_provider.dart';
import '../widgets/product_tile.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductProvider>();
    final provider2 = context.read<ProductProvider>();
    return SafeArea(
      child: Scaffold(
          // appBar: AppBar(
          //   title: const Text('Shopper'),
          // ),
          body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            Expanded(child: buildSearchBar(context)),
            const ShoppingCartIcon(),
            const SizedBox(width: 10)
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 10),
          child: Text(
            'Categories',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        const SizedBox(height: 10),
        // category section
        provider.categories.isEmpty
            ? const CustomLoader(loaderInfo: 'loading categories')
            : Container(
                height: 50,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: provider.categories.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      child: Chip(
                        backgroundColor: Colors.red,
                        label: Text(provider.categories[index]),
                      ),
                    );
                  },
                ),
              ),
        //const SizedBox(height: 10),
        InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                '/all-products',
              );
            },
            child: const Align(
                alignment: Alignment.topRight,
                child: Chip(label: Text('View All Products')))),

        provider.products.isEmpty
            ? const CustomLoader(loaderInfo: 'Loading Products')
            : Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 4,
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
                ),
              ),
      ])),
    );
  }
}
