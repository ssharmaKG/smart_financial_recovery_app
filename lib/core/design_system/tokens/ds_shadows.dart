import 'package:flutter/material.dart';

class DSShadows {
  static const sm = [
    BoxShadow(color: Colors.black12, blurRadius: 2, offset: Offset(0, 1)),
  ];

  static const md = [
    BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 4)),
  ];

  static const lg = [
    BoxShadow(color: Colors.black26, blurRadius: 15, offset: Offset(0, 10)),
  ];
}
