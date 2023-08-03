import 'package:flutter/material.dart';

double drawerWidth = 300;
double actionbarHeight = 60;

extension BoxConstraintsExtension on BoxConstraints {

  double layoutWidth({double? perc}) {
    return maxWidth * (perc ?? 1);
  }

  double layoutHeight({double? perc}) {
    return maxHeight * (perc ?? 1);
  }

}