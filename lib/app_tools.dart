import 'package:flutter/material.dart';

var listItemDecoration = ShapeDecoration(
  color: Colors.white,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  shadows: const [
    BoxShadow(
      color: Color(0x112B374B),
      blurRadius: 12,
      offset: Offset(0, 3),
      spreadRadius: 0,
    )
  ],
);