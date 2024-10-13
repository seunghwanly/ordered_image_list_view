import 'package:flutter/material.dart';

class CallbackImage extends StatefulWidget {
  const CallbackImage.network({
    required this.url,
    required this.onHeightComputed,
    this.onNext,
    this.errorBuilder,
    super.key,
  });

  final Uri url;

  final void Function(double height) onHeightComputed;

  final void Function()? onNext;

  /// `Icons.error` is used as default
  ///
  /// ``` dart
  /// const SizedBox(
  ///   height: 32,
  ///   child: Icon(Icons.error),
  /// )
  /// ```
  final Widget Function(BuildContext, Object, StackTrace)? errorBuilder;

  @override
  State<CallbackImage> createState() => _CallbackImageState();
}

class _CallbackImageState extends State<CallbackImage> {
  late final Image networkImage = Image.network(
    widget.url.toString(),
    errorBuilder: (_, __, ___) => const SizedBox(
      height: 32,
      child: Icon(Icons.error),
    ),
  );

  @override
  void initState() {
    super.initState();

    networkImage.image
        .resolve(
      const ImageConfiguration(),
    )
        .addListener(
      ImageStreamListener(
        (imageInfo, _) {
          widget.onHeightComputed(
            imageInfo.image.height.toDouble(),
          );

          widget.onNext?.call();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return networkImage;
  }
}
