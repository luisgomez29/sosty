import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CarouselImage extends StatelessWidget {
  const CarouselImage({
    Key? key,
    required this.imageUrl,
    this.width,
  }) : super(key: key);

  final String imageUrl;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0,
      width: width ?? 250.0,
      margin: const EdgeInsets.only(
        top: 20.0,
        left: 10.0,
        bottom: 20.0,
        right: 15.0,
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: CachedNetworkImageProvider(
            imageUrl,
          ),
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(10.0),
        ),
        shape: BoxShape.rectangle,
        boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 15.0,
            offset: Offset(0.0, 7.0),
          )
        ],
      ),
    );
  }
}
