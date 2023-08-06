import 'package:weather_band/app/core/api/api_client.dart';
import 'package:weather_band/app/core/base/enum/view_model_state_enum.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';

class BaseViewModel extends ChangeNotifier {
  final api = Modular.get<APIClient>();
  bool isLoading = false;
  String loadingMessage = "";

  ViewModelStateEnum state = ViewModelStateEnum.Idle;

  void notifyChanges() => notifyListeners();

  void setState(ViewModelStateEnum value, {String? message}) {
    loadingMessage = message ?? "";
    state = value;
    notifyListeners();
  }

  Future<void> blockLoading({required Function block, String? message}) async {
    setState(ViewModelStateEnum.Loading, message: message);
    await block();
    setState(ViewModelStateEnum.Idle);
  }

}