import 'package:flutter/foundation.dart';
import 'package:weather_band/app/core/base/enum/view_model_state.dart';

class BaseViewModel extends ChangeNotifier {
  bool isLoading = false;

  ViewModelState state = IdleState();

  void notifyChanges() => notifyListeners();

  void setState(ViewModelState value) {
    state = value;
    notifyListeners();
  }

  Future<void> blockLoading({required Function block, String? message}) async {
    setState(LoadingState(message: message));
    await block();
    setState(IdleState());
  }

}