import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomLoader extends StatelessWidget {
  final String loaderInfo;
  const CustomLoader({
    Key? key,
    required this.loaderInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: LoadingAnimationWidget.threeArchedCircle(
              color: Colors.redAccent,
              size: 20,
            ),
            // child: LoadingAnimationWidget.flickr(
            //   leftDotColor: Colors.pinkAccent.shade400,
            //   rightDotColor: Colors.cyan.shade600,
            //   size: 20,
            // ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              loaderInfo,
              style: const TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
