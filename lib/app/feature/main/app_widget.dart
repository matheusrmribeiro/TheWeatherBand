import 'package:weather_band/app/core/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:oktoast/oktoast.dart';

import '../../core/languages/language_utils.dart';
import '../../core/theme/app_colors.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute(ROUTE_SPLASH);

    return OKToast(
      child: MaterialApp.router(
        title: LanguageUtils.getString("app_name"),
        debugShowCheckedModeBanner: false,
        supportedLocales: [
          Locale("en"),
          Locale("pt"),
        ],
        locale: const Locale("en"),
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: AppColors.primaryColor,
          colorScheme: ColorScheme.fromSwatch().copyWith(secondary: AppColors.accentColor),
          fontFamily: "Montserrat",
        ),
        routeInformationParser: Modular.routeInformationParser,
        routerDelegate: Modular.routerDelegate,
      ),
    );
  }
}
