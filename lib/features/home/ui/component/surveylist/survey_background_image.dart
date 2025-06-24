import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../gen/assets.gen.dart';

class SurveyBackgroundImage extends StatelessWidget {
  final String imageUrl;

  const SurveyBackgroundImage({required this.imageUrl, super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        imageBuilder:
            (context, imageProvider) =>
                Image(image: imageProvider, fit: BoxFit.cover),
        placeholder: (context, url) => Container(color: Colors.black),
        errorWidget:
            (context, url, error) =>
                Assets.images.bgOnboarding.image(fit: BoxFit.cover),
      ),
    );
  }
}
