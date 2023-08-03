import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:weather_band/app/feature/main/app_module.dart';
import 'package:weather_band/app/feature/main/app_widget.dart';

void main() {
  runApp(ModularApp(module: AppModule(), child: AppWidget()));
}