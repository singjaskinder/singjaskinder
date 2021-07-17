import 'package:dlivrDriver/utils/size_config.dart';
import 'package:flutter/material.dart';

class BuildSizedBox extends StatelessWidget {
  const BuildSizedBox({this.width = 1, this.height = 1, this.child, key})
      : super(key: key);
  final double width;
  final double height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width * SizeConfig.widthMultiplier,
      height: height * SizeConfig.heightMultiplier,
      child: child,
    );
  }
}
