import 'package:dlivrDriver/utils/size_config.dart';
import 'package:flutter/material.dart';

import '../res/app_colors.dart';

class BuildText extends StatelessWidget {
  const BuildText(
    this.text, {
    this.size,
    this.color = AppColors.black,
    this.fontWeight = FontWeight.w400,
    this.textAlign,
    this.letterSpacing,
    this.fontFamily = 'MavenPro',
    this.lineHeight,
    this.overflow,
    Key key,
  }) : super(key: key);

  final String text;
  final double size;
  final Color color;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final double letterSpacing;
  final String fontFamily;
  final double lineHeight;
  final TextOverflow overflow;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      style: TextStyle(
        fontSize: size == null
            ? 2.17 * SizeConfig.textMultiplier
            : size * SizeConfig.textMultiplier,
        fontWeight: fontWeight,
        fontFamily: fontFamily,
        color: color,
        letterSpacing: letterSpacing,
        height: lineHeight,
      ),
    );
  }
}
