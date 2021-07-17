import 'package:flutter/widgets.dart';

class SizeConfig {
  static double _screenWidth;
  static double _screenHeight;
  static double _blockWidth = 0;
  static double _blockHeight = 0;

  static double textMultiplier;
  static double imageSizeMultiplier;
  static double heightMultiplier;
  static double widthMultiplier;
  static bool isPortrait = true;
  static bool isMobilePortrait = false;

  void init(BoxConstraints constraints, Orientation orientation) {
    if (orientation == Orientation.portrait) {
      _screenWidth = constraints.maxWidth;
      _screenHeight = constraints.maxHeight;
      isPortrait = true;
      print('Actual: ' + _screenHeight.toString());
      print('Actual: ' + _screenWidth.toString());
      if (_screenWidth < 450) {
        isMobilePortrait = true;
      }
      if (_screenWidth == 360 && _screenHeight == 592) {
        _screenWidth = (_screenWidth * 0.95).roundToDouble();
        _screenHeight = (_screenHeight * 1.2).roundToDouble();
      }
      if (_screenWidth <= 685 && _screenWidth >= 400 ||
          _screenHeight <= 420 && _screenHeight >= 390) {
        _screenWidth = (_screenWidth * 0.95).roundToDouble();
        _screenHeight = (_screenHeight * 1.2).roundToDouble();
      }
    } else {
      _screenWidth = constraints.maxHeight;
      _screenHeight = constraints.maxWidth;
      isPortrait = false;
      isMobilePortrait = false;
    }
    print('------');
    print('Edited: ' + _screenHeight.toString());
    print('Edited: ' + _screenWidth.toString());

    _blockWidth = _screenWidth / 100;
    _blockHeight = _screenHeight / 100;

    textMultiplier = _blockHeight;
    imageSizeMultiplier = _blockWidth;
    heightMultiplier = _blockHeight;
    widthMultiplier = _blockWidth;
  }
}
