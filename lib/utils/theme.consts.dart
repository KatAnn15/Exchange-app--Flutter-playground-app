import 'package:flutter/material.dart';

enum Themes {
    dark,
    light
} 


const gradientColors = {
  Brightness.light: [Colors.tealAccent, Color.fromARGB(255, 23, 241, 248), Color.fromARGB(255, 2, 214, 221)],
  Brightness.dark: [Color.fromARGB(255, 0, 43, 161), Color.fromARGB(255, 23, 158, 248), Color.fromARGB(255, 2, 214, 221)],
};

const headerHeight = 50.0;
const footerHeight = 50.0;