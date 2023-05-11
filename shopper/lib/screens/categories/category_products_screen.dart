import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopper/widgets/cart_icon.dart';
import 'package:shopper/widgets/loader.dart';

import '../../providers/product_provider.dart';
import '../../widgets/product_tile.dart';
import '../../widgets/text_widget.dart';

class CategoryScreenProducts extends StatefulWidget {
  const CategoryScreenProducts({super.key});

  static const routName = '/category_screen';

  @override
  State<CategoryScreenProducts> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<CategoryScreenProducts> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchTextFocusNode = FocusNode();

  @override
  void dispose() {
    _searchController.dispose();
    _searchTextFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final Color color = Utils(context: context).color;
    final size = MediaQuery.of(context).size;

    String catName = ModalRoute.of(context)!.settings.arguments as String;



    final prod = context.watch<ProductProvider>();
    final catProducts = prod.getProductsByCategory(catName);


    //final product = context.watch<Product>();

    return Scaffold(
        appBar: AppBar(
          title: TextWidget(
              text: catName, color: Colors.black, textSize: 22, isTitle: true),
          actions: const [
            ShoppingCartIcon(),
          ],
          //backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
        ),
        body: FutureBuilder(
          future: catProducts,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  _customTextField(),
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.all(10),
                      physics: const BouncingScrollPhysics(),
                      itemCount: _searchController.text.isEmpty
                          ? context.watch<ProductProvider>().products.length
                          : context.watch<ProductProvider>().searchList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        return ChangeNotifierProvider.value(
                          value: _searchController.text.isEmpty
                              ? context.watch<ProductProvider>().products[index]
                              : context
                                  .watch<ProductProvider>()
                                  .searchList[index],
                          child: const productTile(),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Center(
                child: TextWidget(
                  text: 'Error loading products',
                  textSize: 18,
                  color: Colors.red,
                ),
              );
            } else {
              return const CustomLoader(loaderInfo: 'Loading products');
            }
          },
        ));
  }

  Widget _customTextField() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 8, bottom: 8, right: 10),
      child: SizedBox(
        height: kBottomNavigationBarHeight,
        child: TextField(
          controller: _searchController,
          focusNode: _searchTextFocusNode,
          onChanged: (value) {
            //setState(() {});
            context.read<ProductProvider>().searchProducts(value);
          },
          decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      const BorderSide(color: Colors.greenAccent, width: 1)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      const BorderSide(color: Colors.greenAccent, width: 1)),
              hintText: 'What\'s in your mind',
              prefixIcon: const Icon(Icons.search),
              suffix: IconButton(
                  onPressed: (() {
                    _searchController.clear();
                    _searchTextFocusNode.unfocus();
                  }),
                  icon: Icon(
                    Icons.close,
                    color: _searchTextFocusNode.hasFocus
                        ? Colors.red
                        : Colors.grey,
                  ))),
        ),
      ),
    );
  }
}
