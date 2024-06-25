import 'dart:ui';

import 'package:flutter/material.dart';

 const primaryColor = Color(0xff35374B);
const secondaryColor = Color(0xff344955);


Color light = Color(0xFFF7F8FC);
Color lightGrey = Color(0xFFA4A6B3);
Color dark = primaryColor;
Color active = Color(0xFF3C19C0);

final Map<int, Color> _yellow700Map = {
  50:  primaryColor.withOpacity(0.1),
  100:  primaryColor.withOpacity(0.2),
  200:  primaryColor.withOpacity(0.3),
  300:  primaryColor.withOpacity(0.4),
  400:  primaryColor.withOpacity(0.5),
  500:  primaryColor.withOpacity(0.6),
  600:  primaryColor.withOpacity(0.7),
  700:  primaryColor.withOpacity(0.8),
  800:  primaryColor.withOpacity(0.9),
  900:  primaryColor.withOpacity(0.10),
};

final MaterialColor colorSwatch =
    MaterialColor( primaryColor.value, _yellow700Map);
