import 'package:catbreeds/config/helpers/screen_size.dart';
import 'package:flutter/material.dart';

class NavigationService {
  static void goback() => ScreenSize.navigationKey.currentState!.pop();

  static void navigateTo({required Widget screen}) {
    BuildContext? context = ScreenSize.getGlobalContext();
    if (context == null) return;
    FocusScope.of(context).requestFocus(FocusNode());
    ScreenSize.navigationKey.currentState!.push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => screen,
        transitionDuration: const Duration(milliseconds: 900),
        transitionsBuilder: (_, animation, __, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOutQuart;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);
          return SlideTransition(position: offsetAnimation, child: child);
        },
      ),
    );
  }

  static void replaceTo({required Widget screen}) =>
      ScreenSize.navigationKey.currentState!.pushReplacement(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => screen,
          transitionDuration: const Duration(milliseconds: 900),
          transitionsBuilder: (_, animation, __, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOutQuart;
            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);
            return SlideTransition(position: offsetAnimation, child: child);
          },
        ),
      );
}
