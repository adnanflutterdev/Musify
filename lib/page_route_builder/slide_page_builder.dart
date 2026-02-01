import 'package:flutter/material.dart';

Route slidePageBuilderLR(Widget pageRoute){
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => pageRoute,
    transitionDuration: const Duration(milliseconds: 500),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
     var tween = Tween<Offset>(begin: const Offset(-1, 0), end: const Offset(0,0));
     var slidePageAnimation = animation.drive(tween);
     return SlideTransition(position: slidePageAnimation,child: child,);
    },
  );
}

Route slidePageBuilderBT(Widget pageRoute){
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => pageRoute,
    transitionDuration: const Duration(milliseconds: 700),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
     var tween = Tween<Offset>(begin: const Offset(0, 1), end: const Offset(0,0));
     var slidePageAnimation = animation.drive(tween);
     return SlideTransition(position: slidePageAnimation,child: child,);
    },
  );
}