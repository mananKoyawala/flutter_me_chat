// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NetworkImages extends StatelessWidget {
  const NetworkImages({
    super.key,
    required this.url,
    this.errorWidget,
  });
  final String url;
  final Widget? errorWidget;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      height: 80,
      width: 120,
      fit: BoxFit.cover,
      errorWidget: (context, url, error) => Container(
          height: 80,
          width: 120,
          alignment: Alignment.center,
          child: errorWidget ?? Image.asset('assets/images/nonDP.png')),
    );
  }
}

class NetworkImagesChat extends StatelessWidget {
  const NetworkImagesChat({
    super.key,
    required this.url,
    this.errorWidget,
  });
  final String url;
  final Widget? errorWidget;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.cover,
      errorWidget: (context, url, error) => Container(
          height: 80,
          width: 120,
          alignment: Alignment.center,
          child: errorWidget ?? Image.asset('assets/images/nonDP.png')),
    );
  }
}
