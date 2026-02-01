import 'package:flutter/material.dart';

OutlineInputBorder outlinedBorder({
  required Color color,
  required double width,
}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: color, width: width),
  );
}
