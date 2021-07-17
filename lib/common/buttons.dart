import 'package:dlivrDriver/common/sized_box.dart';
import 'package:flutter/material.dart';

import 'text.dart';
import '../res/app_colors.dart';

class BuildPrimaryButton extends StatelessWidget {
  const BuildPrimaryButton({
    this.elevation = 5.0,
    this.borderRadius = 30.0,
    this.fontSize = 2.4,
    this.fontWeight = FontWeight.bold,
    this.fontFamily,
    @required this.onTap,
    this.color = AppColors.medViolet,
    @required this.label,
    this.textColor = AppColors.white,
    this.verticalPadding = 10.0,
    this.horizontalPadding = 1.0,
    this.isEnabled = true,
    this.isOutLined = false,
  });

  final double elevation;
  final double borderRadius;
  final double fontSize;
  final FontWeight fontWeight;
  final String fontFamily;
  final double verticalPadding;
  final double horizontalPadding;
  final VoidCallback onTap;
  final Color color;
  final String label;
  final Color textColor;
  final bool isEnabled;
  final bool isOutLined;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        child: Material(
          borderRadius: BorderRadius.circular(borderRadius),
          elevation: isEnabled
              ? isOutLined
                  ? 0
                  : elevation
              : 0,
          color: isEnabled
              ? isOutLined
                  ? AppColors.transparent
                  : color
              : AppColors.transparent,
          child: InkWell(
            splashColor: AppColors.darkViolet,
            borderRadius: BorderRadius.circular(borderRadius),
            onTap: isEnabled ? onTap : null,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                border: Border.all(
                    width: 1.2,
                    color: isEnabled
                        ? color
                        : AppColors.darkGrey.withOpacity(0.2)),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalPadding,
              ),
              child: Center(
                child: BuildText(label,
                    color: isEnabled
                        ? isOutLined
                            ? color
                            : textColor
                        : AppColors.darkGrey.withOpacity(0.4),
                    size: fontSize,
                    fontFamily: fontFamily,
                    fontWeight: fontWeight),
              ),
            ),
          ),
        ));
  }
}

class BuildSecondaryButton extends StatelessWidget {
  const BuildSecondaryButton({
    Key key,
    @required this.onTap,
    @required this.label,
    this.color = AppColors.darkViolet,
    this.labelSize = 2.17,
  }) : super(key: key);

  final VoidCallback onTap;
  final String label;
  final double labelSize;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.transparent,
      child: InkWell(
        splashColor: AppColors.violet.withOpacity(0.5),
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 4.0,
            horizontal: 8.0,
          ),
          child: BuildText(
            label,
            color: color,
            size: labelSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class BuildIconTextButton extends StatelessWidget {
  const BuildIconTextButton({
    Key key,
    @required this.onTap,
    @required this.iconData,
    this.iconSize,
    @required this.label,
    this.labelSize = 2.17,
    this.color = AppColors.darkViolet,
    this.isFill = false,
  }) : super(key: key);

  final VoidCallback onTap;
  final IconData iconData;
  final double iconSize;
  final String label;
  final double labelSize;
  final Color color;
  final bool isFill;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isFill ? color : AppColors.transparent,
      borderRadius: BorderRadius.all(
        Radius.circular(12),
      ),
      child: InkWell(
        splashColor: AppColors.violet.withOpacity(0.5),
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
        onTap: onTap,
        child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                border: Border.all(color: color)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  iconData,
                  color: isFill ? AppColors.white : color,
                  size: iconSize,
                ),
                BuildSizedBox(),
                BuildText(
                  label,
                  color: isFill ? AppColors.white : color,
                  size: labelSize,
                  fontWeight: FontWeight.bold,
                ),
              ],
            )),
      ),
    );
  }
}
