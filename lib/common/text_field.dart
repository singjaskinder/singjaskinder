import 'package:dlivrDriver/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../res/app_styles.dart';

class BuildCustomTextField extends StatelessWidget {
  const BuildCustomTextField(
      {this.controller,
      this.onChanged,
      this.validator,
      this.hint,
      this.isPassword = false,
      this.centerCursor = false,
      this.textInputType = TextInputType.name,
      this.prefixIcon,
      this.suffixIcon,
      this.lines = 1,
      this.toEnabled = true,
      this.textInputAction = TextInputAction.next,
      this.showShadowWhenDisabled = false,
      this.showShadow = true,
      this.maxLength,
      this.isDense = true,
      Key key})
      : super(key: key);

  final TextEditingController controller;
  final void Function(String) onChanged;
  final String Function(String) validator;
  final String hint;
  final bool isPassword;
  final bool centerCursor;
  final TextInputType textInputType;
  final Widget prefixIcon;
  final Widget suffixIcon;
  final int lines;
  final bool toEnabled;
  final bool showShadowWhenDisabled;
  final bool showShadow;
  final TextInputAction textInputAction;
  final int maxLength;
  final bool isDense;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(50.0),
            ),
            boxShadow: toEnabled
                ? showShadow
                    ? [AppStyles.textFieldShadow]
                    : []
                : showShadowWhenDisabled
                    ? [AppStyles.textFieldShadow]
                    : [],
          ),
          child: TextFormField(
            enabled: false,
            maxLines: lines,
            decoration: AppStyles.primaryTextFieldDecor.copyWith(
              counterText: '',
              isDense: isDense,
            ),
          ),
        ),
        TextFormField(
          cursorColor: AppColors.violet,
          keyboardType: textInputType,
          controller: controller,
          textInputAction: textInputAction,
          obscureText: isPassword,
          enabled: toEnabled,
          maxLines: lines,
          validator: validator,
          maxLength: maxLength,
          onChanged: onChanged,
          textAlign: centerCursor ? TextAlign.center : TextAlign.left,
          style: TextStyle(
            fontFamily: 'MavenPro',
          ),
          decoration: AppStyles.primaryTextFieldDecor.copyWith(
            counterText: '',
            isDense: isDense,
            hintText: hint,
            hintStyle: AppStyles.primaryTextStyle
                .copyWith(color: AppColors.darkViolet.withOpacity(0.5)),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}
