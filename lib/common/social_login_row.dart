import 'dart:io' show Platform;
import 'package:dlivrDriver/common/text.dart';
import 'package:dlivrDriver/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'sized_box.dart';

class BuildSocialLoginRow extends StatelessWidget {
  const BuildSocialLoginRow({
    Key key,
    @required this.onGoogleTap,
    @required this.onFacebookTap,
    @required this.onAppleTap,
  }) : super(key: key);

  final VoidCallback onGoogleTap;
  final VoidCallback onFacebookTap;
  final VoidCallback onAppleTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BuildSizedBox(
          height: 1.3,
        ),
        Center(
          child: BuildText(
            'or',
            color: AppColors.black,
          ),
        ),
        BuildSizedBox(
          height: 1.3,
        ),
        Center(
          child: BuildText(
            'Connect with',
            color: AppColors.black,
          ),
        ),
        BuildSizedBox(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                onTap: onGoogleTap,
                child: Container(
                  padding: const EdgeInsets.all(4.0),
                ),
              ),
            ),
            BuildSizedBox(width: 4.0),
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                onTap: onFacebookTap,
                child: Container(
                  padding: const EdgeInsets.all(4.0),
                ),
              ),
            ),
            BuildSizedBox(width: Platform.isIOS ? 4.0 : 0.0),
          ],
        ),
      ],
    );
  }
}
