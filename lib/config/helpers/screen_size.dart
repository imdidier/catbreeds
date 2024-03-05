import 'package:flutter/material.dart';

class ScreenSize {
  static double width = 0;
  static double height = 0;
  static double absoluteHeight = 0;
  static double top = 0;

  static GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  static BuildContext? getGlobalContext() => navigationKey.currentContext;

  static void init() {
    BuildContext? context = getGlobalContext();
    if (context == null) return;
    double deviceHeight = MediaQuery.of(context).size.height;
    top = MediaQuery.of(context).viewPadding.top;
    height = deviceHeight;
    width = MediaQuery.of(context).size.width;
    absoluteHeight = deviceHeight - top;
  }
}
