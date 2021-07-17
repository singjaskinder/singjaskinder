import 'package:dlivrDriver/common/text.dart';
import 'package:flutter/widgets.dart';

class BuildTextUp extends StatelessWidget {
  const BuildTextUp(
      {@required this.normalText, @required this.upperText, Key key})
      : super(key: key);
  final BuildText normalText;
  final BuildText upperText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [normalText, upperText],
    );
  }
}
