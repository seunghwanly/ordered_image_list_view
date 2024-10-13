import 'package:flutter/material.dart';

import 'callback_image.dart';
import 'ordered_image_mixin.dart';

class OrderedImageListView extends StatefulWidget {
  const OrderedImageListView.network({
    required this.urls,
    super.key,
  });

  final List<Uri> urls;

  @override
  State<OrderedImageListView> createState() => _OrderedImageListViewState();
}

class _OrderedImageListViewState extends State<OrderedImageListView>
    with OrderedImageMixin {
  @override
  List<Uri> get urls => widget.urls;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CallbackImage>(
      stream: imageController.stream,
      builder: (context, snapshot) {
        return ListView.builder(
          cacheExtent: cachedExtent,
          itemCount: images.length,
          itemBuilder: (_, index) => images[index],
        );
      },
    );
  }
}
