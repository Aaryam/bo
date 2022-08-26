import 'package:flutter/material.dart';

class ColorUtils {
  static const Map<int, Color> deepGreenMap = {
    50: Color.fromRGBO(127, 179, 115, 0.1),
    100: Color.fromRGBO(127, 179, 115, 0.2),
    200: Color.fromRGBO(127, 179, 115, 0.3),
    300: Color.fromRGBO(127, 179, 115, 0.4),
    400: Color.fromRGBO(127, 179, 115, 0.5),
    500: Color.fromRGBO(127, 179, 115, 0.6),
    600: Color.fromRGBO(127, 179, 115, 0.7),
    700: Color.fromRGBO(127, 179, 115, 0.8),
    800: Color.fromRGBO(127, 179, 115, 0.9),
    900: Color.fromRGBO(127, 179, 115, 1),
  };

  static MaterialColor deepGreen = const MaterialColor(0xFF7FB373, deepGreenMap);
}
