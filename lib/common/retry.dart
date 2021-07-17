import 'package:dlivrDriver/utils/size_config.dart';
import 'package:flutter/material.dart';

import 'buttons.dart';
import 'sized_box.dart';
import 'text.dart';

class BuildRetry extends StatelessWidget {
  BuildRetry({@required this.onRetry, this.label = 'Something went wrong...'});
  final String label;
  final Function onRetry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BuildText('Something went wrong...'),
          BuildSizedBox(),
          Container(
            width: SizeConfig.widthMultiplier * 20,
            child: BuildPrimaryButton(
              onTap: onRetry,
              label: 'Retry',
              elevation: 0,
              verticalPadding: 8,
              horizontalPadding: 10,
              borderRadius: 4,
            ),
          )
        ],
      ),
    );
  }
}
