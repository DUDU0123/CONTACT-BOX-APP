import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  final Widget? child;
  final ShapeBorder? shapeBorder;
  const ShimmerWidget.rectangular({
    super.key,
    this.width = double.infinity,
    required this.height,
    this.child,
    this.shapeBorder,
  });
  const ShimmerWidget.circular({
    super.key,
    this.width = double.infinity,
    required this.height,
    this.child,
    this.shapeBorder,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[400]!,
      highlightColor: Colors.grey[300]!,
      child: Container(
        height: height,
        width: width,
        decoration: ShapeDecoration(
            color: Colors.grey,
            shape: shapeBorder ?? const RoundedRectangleBorder()),
        child: child,
      ),
    );
  }
}