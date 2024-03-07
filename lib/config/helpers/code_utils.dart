import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CodeUtils {
  static showBoxShadow() {
    return const BoxShadow(
      color: Colors.black45,
      spreadRadius: 0,
      blurRadius: 2,
      offset: Offset(0, 3),
    );
  }

  static showLottie(String assetPath) {
    return Lottie.asset(
      assetPath,
      frameRate: FrameRate.max,
    );
  }
}
