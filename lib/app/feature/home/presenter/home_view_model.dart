import 'package:weather_band/app/core/base/base_view_model.dart';

class HomeViewModel extends BaseViewModel {

  int _count = 0;
  int get count => _count;

  void increment() {
    _count += 1;
    notifyListeners();
  }

}