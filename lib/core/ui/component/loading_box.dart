import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../theme/app_dimension.dart';

class LoadingBox extends StatelessWidget {
  final double width;
  final double height;

  const LoadingBox({required this.width, required this.height, super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppDimension.borderRadius),
      child: Shimmer(
        child: SizedBox(
          width: width,
          height: height,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(AppDimension.borderRadius),
            ),
          ),
        ),
      ),
    );
  }
}
