import 'package:flutter/material.dart';

final Color primaryColor = Color(0xFF0077B6); // Soft Blue Theme
  final Color backgroundColor = Color(0xFFF0F4F8); // Soft Grey-Blue Background

// Lets replace all static sizes
const double kDesktopMaxWidth = 1000.0;
const double kTabletMaxWidth = 760.0;
double getMobileMaxWidth(BuildContext context) =>
    MediaQuery.of(context).size.width * .8;
