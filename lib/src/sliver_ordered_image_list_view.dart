import 'package:flutter/material.dart';

import 'callback_image.dart';
import 'ordered_image_mixin.dart';

class SliverOrderedImageListView extends StatefulWidget {
  const SliverOrderedImageListView.network({
    required this.urls,
    super.key,
  });

  final List<Uri> urls;

  @override
  State<SliverOrderedImageListView> createState() =>
      _SliverOrderedImageListViewState();
}

class _SliverOrderedImageListViewState extends State<SliverOrderedImageListView>
    with OrderedImageMixin {
  @override
  List<Uri> get urls => widget.urls;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CallbackImage>(
      stream: imageController.stream,
      builder: (context, snapshot) {
        return SliverList.builder(
          itemCount: images.length,
          itemBuilder: (_, index) => images[index],
        );
      },
    );
  }
}
