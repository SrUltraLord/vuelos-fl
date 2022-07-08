import 'package:flutter/material.dart';

class BoxDecorations {
  static final cardDecoration = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: const [
        BoxShadow(
          color: Colors.black54,
          blurRadius: 25,
        )
      ]);
}
