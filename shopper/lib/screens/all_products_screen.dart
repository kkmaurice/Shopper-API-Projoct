import 'package:flutter/material.dart';

class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Products'),
        centerTitle: true,
      ),
      body: const Center(
          child: Center(
        child: Text('All Products'),
      )),
    );
  }
}
