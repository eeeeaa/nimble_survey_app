import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class LoadingCircle extends StatelessWidget {
  final double radius;

  const LoadingCircle({required this.radius, super.key});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Shimmer(
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white24, width: radius),
          ),
        ),
      ),
    );
  }
}
