import 'package:flutter/material.dart';

class EmptySpace extends StatelessWidget {
  final double? width;
  final double? height;
  const EmptySpace({super.key,this.width,this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width??0,
      height: height??0,
    );
  }
}
