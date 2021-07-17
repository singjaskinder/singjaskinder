import 'package:dlivrDriver/utils/local.dart';
import 'package:dlivrDriver/utils/size_config.dart';
import 'package:flutter/material.dart';

import 'sized_box.dart';
import 'text.dart';

class BuildNoContent extends StatelessWidget {
  const BuildNoContent({@required this.image, @required this.title, Key key})
      : super(key: key);
  final String image;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: SizeConfig.heightMultiplier * 70,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                getImage(image),
                width: SizeConfig.imageSizeMultiplier * 75,
              ),
              BuildSizedBox(height: 2),
              BuildText(
                title,
                size: 2.4,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        ));
  }
}
