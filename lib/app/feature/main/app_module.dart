import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_band/app/core/languages/language_view_model.dart';
import 'package:weather_band/app/core/routes.dart';
import 'package:weather_band/app/feature/home/presenter/home_page.dart';
import 'package:weather_band/app/feature/home/presenter/home_view_model.dart';
import 'package:weather_band/app/feature/splash/splash_page.dart';

import 'guards/data_injection_guard.dart';

/// ATTENTION
///
/// How this test will have only two screens I haven't separated into
/// modules, I just used the initial idea of modules.
class AppModule extends Module {
  @override
  List<Bind> get binds => [
        AsyncBind((i) => SharedPreferences.getInstance()),
        Bind((i) => LanguageViewModel()),
        Bind((i) => HomeViewModel()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(ROUTE_SPLASH,
            child: (context, args) => SplashPage(),
            transition: TransitionType.noTransition,
            guards: [
              InitializeGuard(),
            ]),
        ChildRoute(ROUTE_INITIAL,
            child: (context, args) => HomePage(),
            transition: TransitionType.noTransition,
            guards: [
              InitializeGuard(),
            ]),
      ];
}
