import 'dart:async';

import 'package:flutter/material.dart';

import 'callback_image.dart';

mixin OrderedImageMixin<T extends StatefulWidget> on State<T> {
  @protected
  List<Uri> get urls;

  final List<Widget> images = [];

  double cachedExtent = 0;

  final StreamController<CallbackImage> imageController =
      StreamController<CallbackImage>.broadcast();

  void addImage(int index) {
    if (index > urls.length - 1 || index <= images.length - 1) {
      return;
    }

    return imageController.add(
      CallbackImage.network(
        key: ValueKey('callback_image_${hashCode}_$index'),
        url: urls[index],
        onHeightComputed: (h) => cachedExtent += h,
        onNext: () => addImage(index + 1),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    imageController.stream.listen(
      (image) {
        images.add(image);
        setState(() {});
      },
    );

    addImage(0);
  }

  @override
  void dispose() {
    imageController.close();
    super.dispose();
  }
}
