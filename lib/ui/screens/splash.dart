import 'package:catbreeds/config/services/fast_cached_image_service.dart';
import 'package:catbreeds/config/services/navigation_service.dart';
import 'package:catbreeds/ui/providers/cat_provider.dart';
import 'package:catbreeds/ui/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../config/helpers/screen_size.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void didChangeDependencies() async {
    ScreenSize.init();
    FastCacheImageService.initImagesCacheConfig();
    bool resp = await context.read<CatProvider>().getListCat();
    if (!resp) return;
    NavigationService.replaceTo(screen: const HomeScreen());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
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
              ),
            ),
            SizedBox(height: ScreenSize.top * 5),
            Container(
              alignment: Alignment.center,
              height: ScreenSize.absoluteHeight * 0.4,
              child: Lottie.asset(
                'assets/lotties/splash.json',
                frameRate: FrameRate.max,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
