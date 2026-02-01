import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Route fadePageBuilder(int milliseconds, Widget pageroute) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => pageroute,
    transitionDuration: Duration(milliseconds: milliseconds),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var tween = Tween<double>(begin: 0, end: 1);
      var fadeAnimation = animation.drive(tween);
      return FadeTransition(opacity: fadeAnimation, child: child);
    },
  );
}
