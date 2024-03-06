import 'package:catbreeds/config/helpers/screen_size.dart';
import 'package:catbreeds/config/themes/app_theme.dart';
import 'package:catbreeds/ui/providers/cat_provider.dart';
import 'package:catbreeds/ui/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CatProvider()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CatBreeds',
      debugShowCheckedModeBanner: false,
      navigatorKey: ScreenSize.navigationKey,
      theme: AppTheme().getTheme(),
      home: const SplashScreen(),
    );
  }
}
