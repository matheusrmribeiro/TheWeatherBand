import 'package:flutter/material.dart';

double drawerWidth = 300;
double actionbarHeight = 60;

extension ScreenExtension on BuildContext {

  double screenWidth({double? perc}) {
    return MediaQuery.sizeOf(this).width * (perc ?? 1);
  }

  double screenHeight({double? perc}) {
    return MediaQuery.sizeOf(this).height * (perc ?? 1);
  }

  double bodyWidth({double? perc}) {
    return (MediaQuery.sizeOf(this).width - drawerWidth) * (perc ?? 1);
  }

}