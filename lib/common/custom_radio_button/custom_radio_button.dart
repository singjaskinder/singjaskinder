import 'package:dlivrDriver/res/app_colors.dart';
import 'package:flutter/material.dart';

import '../text.dart';
import 'radio_button_text_position.dart';

class RadioButton<T> extends StatelessWidget {
  final String description;
  final T value;
  final T groupValue;
  final void Function(T) onChanged;
  final RadioButtonTextPosition textPosition;

  const RadioButton({
    @required this.description,
    @required this.value,
    @required this.groupValue,
    @required this.onChanged,
    this.textPosition = RadioButtonTextPosition.right,
  });

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () => this.onChanged(value),
        child: SizedBox(
          height: 28.0,
          child: Row(
            mainAxisAlignment:
                this.textPosition == RadioButtonTextPosition.right
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.end,
            children: <Widget>[
              this.textPosition == RadioButtonTextPosition.left
                  ? Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        this.description,
                        textAlign: TextAlign.left,
                      ),
                    )
                  : Container(),
              Radio<T>(
                groupValue: groupValue,
                onChanged: this.onChanged,
                value: this.value,
                activeColor: AppColors.violet,
              ),
              this.textPosition == RadioButtonTextPosition.right
                  ? Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: BuildText(
                        this.description,
                        textAlign: TextAlign.right,
                        size: 1.56,
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      );
}
