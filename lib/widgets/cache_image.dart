import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '/widgets/widgets.dart';

class CacheImage extends StatelessWidget {
  const CacheImage(
      {super.key,
      required this.imageUrl,
      this.height = 100,
      this.width = double.infinity, this.fit= BoxFit.cover});
  final String imageUrl;
  final double? height;
  final double? width;
  final BoxFit ? fit;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      
      placeholder: (context, url) => const CircleIndicator(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
      fadeOutDuration: const Duration(seconds: 1),
                fadeInDuration: const Duration(seconds: 3),
    );
  }
}
