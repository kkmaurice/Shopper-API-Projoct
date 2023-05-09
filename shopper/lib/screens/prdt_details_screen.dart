import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shopper/models/product_model.dart';
import 'package:shopper/widgets/cart_icon.dart';

import '../providers/product_provider.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({super.key});

  @override
  Widget build(BuildContext context) {
    int proId = ModalRoute.of(context)!.settings.arguments as int;
    final product = context.watch<ProductProvider>().getProductById(proId);
    return SafeArea(
      child: Scaffold(
          body: CustomScrollView(
        slivers: [
          SliverAppBar(
            //backgroundColor: Colors.blue.withOpacity(0.7),
            //leading: const Icon(Icons.menu),
            actions: [
              // share
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {
                  Share.share('check out this product');
                },
              ),
              const ShoppingCartIcon(),
              const SizedBox(width: 10)
            ],
            pinned: true,
            expandedHeight: 300,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Flutter Sliver'),
              centerTitle: true,
              background: Hero(
                  tag: product.id!,
                  child: Image.network(
                    product.image!,
                    fit: BoxFit.cover,
                  )),
            ),
          ),
          SliverToBoxAdapter(
            child: middleWidget(product: product),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 10,
                  ),
                ),
                onPressed: () {},
                child: const Text('Add to Cart'),
              ),
            ),
          )
        ],
      )),
    );
  }
}

class middleWidget extends StatelessWidget {
  const middleWidget({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          priceRow(product: product),
          const SizedBox(height: 10),
          // rating bar
          const ratingWidget(),
          const SizedBox(height: 10),
          Text(
            product.title!,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            product.description!,
            style: TextStyle(
              fontSize: 16,
              fontStyle: GoogleFonts.robotoSlab().fontStyle,
            ),
          ),
        ],
      ),
    );
  }
}

class ratingWidget extends StatelessWidget {
  const ratingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Tap to Rate: ',
          style: TextStyle(
            fontSize: 16,
            fontFamily: GoogleFonts.robotoSlab().fontFamily,
          ),
        ),
        RatingBar.builder(
          initialRating: 3.5,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemSize: 20,
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {},
        ),
      ],
    );
  }
}

class priceRow extends StatelessWidget {
  const priceRow({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'Price: ',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        Text(
          '\$${product.price}',
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
        ),
      ],
    );
  }
}
