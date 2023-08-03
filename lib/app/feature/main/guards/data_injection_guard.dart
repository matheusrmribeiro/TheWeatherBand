import 'package:weather_band/app/feature/main/app_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class InitializeGuard extends RouteGuard {
  @override
  Future<bool> canActivate(String path, ModularRoute route) async {
    await Modular.isModuleReady<AppModule>();
    return true;
  }
}
