import 'dart:math';

import 'package:flutter/material.dart';

class SizeConfig {
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;
  static double _safeAreaHorizontal;
  static double _safeAreaVertical;
  static double safeBlockHorizontal;
  static double safeBlockVertical;
  static double _safeFactorHorizontal;
  static double _safeFactorVertical;
  static double safeAreaTextScalingFactor;

  static bool isStandardScreen;

  SizeConfig.init(BuildContext context) {
    var _mediaQueryData = MediaQuery.of(context);
    final _divisor = 400;
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;

    isStandardScreen = screenHeight > 650 ? true : false;
    _safeFactorHorizontal = (screenWidth - _safeAreaHorizontal) / _divisor;
    _safeFactorVertical = (screenHeight - _safeAreaVertical) / _divisor;

    safeAreaTextScalingFactor = min(_safeFactorVertical, _safeFactorHorizontal);
  }
}
