import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LinerShimmerLoading extends StatelessWidget {
  final double width;
  final double height;
  final double radius;
  final Color? widgetColor;


  const LinerShimmerLoading._({
    this.width = double.infinity,
    this.height = double.infinity,
    this.radius = double.infinity,
    this.widgetColor = const Color(0xff076579),
    Key? key}) : super(key: key);

  const LinerShimmerLoading.Square({
    required double width,
    required double height,
    required double radius,
    required Color color,
  }) : this._(width: width , height: height , radius: radius , widgetColor: color);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: widgetColor!,
      highlightColor: Colors.blueGrey,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          color: widgetColor,
        ),
      ),
    );
  }
}
