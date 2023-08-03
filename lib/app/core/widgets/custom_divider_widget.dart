import 'package:flutter/material.dart';

class CustomDividerWidget extends StatelessWidget {
  const CustomDividerWidget({Key? key, this.height, this.width, this.color}) : super(key: key);

  final double? height;
  final double? width;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      height: height,
      width: width,
    );
  }
}
