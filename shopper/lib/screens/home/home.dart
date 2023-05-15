// ignore_for_file: sized_box_for_whitespace, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopper/models/product_model.dart';
import 'package:shopper/widgets/cart_icon.dart';
import 'package:shopper/widgets/loader.dart';
import 'package:shopper/widgets/search_bar_widget.dart';

import '../../providers/dark_theme_provider.dart';
import '../../providers/product_provider.dart';
import '../../widgets/product_tile.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductProvider>();
    final provider2 = context.read<ProductProvider>();

    Color theme = context.watch<DarkThemeProvider>().darkTheme
        ? Colors.white
        : Colors.black;
    return SafeArea(
      child: Scaffold(
          // appBar: AppBar(
          //   title: const Text('Shopper'),
          // ),
          body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hello, John Doe',
                  style: TextStyle(
                      color: theme, fontSize: 16, fontWeight: FontWeight.w700)),
              Text('What are buying today?',
                  style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 12,
                      fontWeight: FontWeight.w400)),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(child: buildSearchBar(context)),
            const ShoppingCartIcon(),
            const SizedBox(width: 5)
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(
            left: 10,
          ),
          child: Text(
            'Top Categories',
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        // const SizedBox(height: 5),
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
                      child: GestureDetector(
                        onTap: () {
                          //print(provider.categories[index]);
                          provider2.getProductsByCategory(
                              provider.categories[index]);
                          // Navigator.pushNamed(
                          //   context,
                          //   '/category-screen',
                          //   arguments: provider.categories[index],
                          // );
                        },
                        child: Chip(
                          backgroundColor: provider.selectedCategoryIndex ==
                                  provider.categories[index]
                              ? Colors.grey
                              : Colors.red,
                          label: Text(provider.categories[index]),
                        ),
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
            : Consumer<ProductProvider>(builder: (context, data, child) {
                List<Product> products = data.products;
                print("THE LENGTH OF PRODUCTS IS ${products.length}");

                return Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: products.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.7,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemBuilder: (context, index) {
                            // return Text(
                            //     provider.productsByCategory[index].title!);
                            return ChangeNotifierProvider.value(
                                value: products[index],
                                child: const productTile());
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }),
      ])),
    );
  }
}
