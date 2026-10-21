import 'package:flutter/material.dart';

class AppNavigator {
  static final navigatorKey = GlobalKey<NavigatorState>();

  AppNavigator._();

  static NavigatorState get _navigator {
    final key = navigatorKey.currentState;
    if (key == null) {
      throw Exception('Navigator key is not initialized');
    }
    return key;
  }

  static Future<T?> push<T>(Widget screen) {
    return _navigator.push<T>(MaterialPageRoute(builder: (_) => screen));
  }

  static Future<T?> pushDelayed<T>(Widget screen, {int delay = 100}) async {
    await Future.delayed(Duration(milliseconds: delay));
    return _navigator.push<T>(MaterialPageRoute(builder: (_) => screen));
  }

  static Future<T?> pushReplacement<T>(Widget screen) {
    return _navigator.pushReplacement<T, T>(
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  static Future<T?> pushAndRemoveAll<T>(Widget screen) {
    return _navigator.pushAndRemoveUntil<T>(
      MaterialPageRoute(builder: (_) => screen),
      (route) => false,
    );
  }

  static void pop<T extends Object>([T? results]) {
    if (_navigator.canPop()) {
      _navigator.pop(results);
    }
  }
}
