// ignore_for_file: camel_case_types

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../models/product_model.dart';

class productTile extends StatelessWidget {
  const productTile({
    super.key,
    //required this.provider,
  });

  //final ProductProvider provider;

  @override
  Widget build(BuildContext context) {
    final prod = context.watch<Product>();
    return Container(
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              height: 100.0,
              width: 200.0,
              color: Colors.grey[200],
              child: prod.image == null
                  ? Image.asset('shopper/assets/images/image8.jpg')
                  : ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5.0),
                        topRight: Radius.circular(5.0),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: prod.image ?? '',
                        //width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Center(
                          child: SizedBox(
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey,
                              highlightColor: Colors.grey.shade600,
                              child: Icon(
                                Ionicons.image_outline,
                                size: 100,
                                color: Colors.grey[100],
                              ),
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => const Center(
                          child: SizedBox(
                            child: Icon(Ionicons.images_outline),
                          ),
                        ),
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 7),
          Text(
            prod.title!,
            style: const TextStyle(
              fontSize: 12,
              // fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 7),
          RatingBar.builder(
            initialRating: 3,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemSize: 18,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              print(rating);
            },
          ),
          const SizedBox(height: 10),
          Text(
            'Shs ${prod.price}',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
