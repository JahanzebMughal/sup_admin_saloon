import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:saloon_app/Constants/ColorsManager.dart';

class Customloading {
  Widget loader() {
    return Center(
        child: LoadingAnimationWidget.flickr(
      leftDotColor: ColorManager.primaryColor,
      rightDotColor: ColorManager.secondaryColor,
      size: 30,
    ));
  }

  static Widget cicularprogress(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: const Center(
            child: CircularProgressIndicator(
          color: lightprimarycolor,
        )));
  }
}
