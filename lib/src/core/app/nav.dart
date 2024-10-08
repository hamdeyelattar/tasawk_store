import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';

const _defaultTransition = PageTransitionType.rightToLeftWithFade;
const _alignment = Alignment.center;
const _duration = Duration(milliseconds: 400);

class NV {
  static Future<void> nextScreen(BuildContext context, Widget page) {
    return Navigator.push(
      context,
      PageTransition(
        child: page,
        duration: _duration,
        alignment: _alignment,
        type: _defaultTransition,
      ),
    );
  }

  static Future<void> nextScreenOS(BuildContext context, Widget page) {
    return Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => page),
    );
  }

  static void pop(BuildContext context) {
    Navigator.pop(context);
  }

  static Future<void> nextScreenCloseOthers(BuildContext context, Widget page) {
    return Navigator.pushAndRemoveUntil(
      context,
      PageTransition(
        child: page,
        duration: _duration,
        alignment: _alignment,
        type: _defaultTransition,
      ),
      (route) => false,
    );
  }

  static Future<void> nextScreenReplace(BuildContext context, Widget page) {
    return Navigator.pushReplacement(
      context,
      PageTransition(
        child: page,
        duration: _duration,
        alignment: _alignment,
        type: _defaultTransition,
      ),
    );
  }

  // Named

  static Future<void> nextScreenNamed(BuildContext context, String routeName,
      {args}) {
    return Navigator.pushNamed(context, routeName, arguments: args);
  }

  static Future<void> nextScreenOSNamed(
    BuildContext context,
    String routeName,
    String args,
  ) {
    return Navigator.pushNamed(context, routeName, arguments: args);
  }

  static void nextScreenCloseOthersNamed(
    BuildContext context,
    String routeName,
  ) {
    Navigator.restorablePushNamedAndRemoveUntil(
      context,
      routeName,
      (route) => false,
    );
  }

  static Future<void> nextScreenReplaceNamed(
      BuildContext context, String routeName,
      {args}) {
    return Navigator.pushReplacementNamed(context, routeName, arguments: args);
  }

  static Future<void> nextScreenPopup(BuildContext context, Widget page) {
    return Navigator.push(
      context,
      PageTransition(
        child: page,
        duration: _duration,
        alignment: _alignment,
        type: _defaultTransition,
        fullscreenDialog: true,
      ),
    );
  }
}
