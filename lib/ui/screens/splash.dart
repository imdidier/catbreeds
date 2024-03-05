import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../config/helpers/screen_size.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSize.init();

    return Scaffold(
      body: SizedBox(
        height: ScreenSize.absoluteHeight,
        width: ScreenSize.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Catbreeds',
              style: TextStyle(
                fontSize: ScreenSize.width * 0.08,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SizedBox(height: ScreenSize.top * 5),
            Image.asset(
              'assets/images/cat_logo.jpg',
              fit: BoxFit.fill,
              height: ScreenSize.absoluteHeight * 0.5,
            ),
          ],
        ),
      ),
    );
  }
}
