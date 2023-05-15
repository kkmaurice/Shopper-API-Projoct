import 'package:flutter/material.dart';
import 'package:shopper/widgets/text_widget.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({
    Key? key,
    required this.catText,
    //required this.impPath,
    required this.color,
  }) : super(key: key);

  final String catText;
  //final String impPath;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed('/category-products-screen', arguments: catText);
      },
      child: Container(
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.red.withOpacity(0.7), width: 2)),
        child: Container(
          alignment: Alignment.center,
          height: screenSize.height * 0.2,
          width: screenSize.width * 0.3,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16), color: color),
          child: TextWidget(
            text: catText,
            color: Colors.white,
            textSize: 20,
            isTitle: true,
          ),
        ),
      ),
    );
  }
}
