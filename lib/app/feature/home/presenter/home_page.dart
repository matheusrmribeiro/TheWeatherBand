import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:weather_band/app/core/base/enum/view_model_state.dart';
import 'package:weather_band/app/core/constants.dart';
import 'package:weather_band/app/core/enums.dart';
import 'package:weather_band/app/core/languages/language_utils.dart';
import 'package:weather_band/app/core/theme/app_colors.dart';
import 'package:weather_band/app/core/widgets/custom_empty_widget.dart';
import 'package:weather_band/app/core/widgets/custom_loading_widget.dart';
import 'package:weather_band/app/feature/home/presenter/home_view_model.dart';
import 'package:weather_band/app/feature/home/presenter/widgets/weather_widget.dart';

import '../../../core/widgets/custom_error_widget.dart';
import 'widgets/header_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final viewModel = Modular.get<HomeViewModel>();

  late TabController _tabController;

  void onRefresh() {
    viewModel.fetchData();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: FORECAST_TRACKING_DAYS, vsync: this);
    viewModel.fetchData();
  }

  Color getBackgroundColor() {
    return HSLColor.fromColor(AppColors.sunnyColor)
        .withSaturation(0.8)
        .toColor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (BuildContext context, Widget? child) {
          _tabController.index = 0;
          Widget widget;
          switch (viewModel.state) {
            case IdleState():
              {
                if (viewModel.selectedCity == null) {
                  widget = CustomEmptyWidget(
                    message: LanguageUtils.getString("select_city"),
                  );
                } else if (viewModel.weekDayList.isEmpty) {
                  widget = CustomEmptyWidget(
                      message: LanguageUtils.getString("empty_data"),
                      onRefresh: onRefresh);
                } else {
                  widget = WeatherWidget(
                    tabController: _tabController,
                    weekDayList: viewModel.weekDayList,
                  );
                }
              }
            case LoadingState(message: var message):
              {
                widget = CustomLoadingWidget(message: message ?? "");
              }
            case ErrorState(message: var error):
              {
                widget = CustomErrorWidget(
                  message: error ?? "",
                  onRefresh: onRefresh,
                );
              }
          }

          return Stack(
            children: [
              Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                child: widget,
              ),
              Align(
                alignment: Alignment.topCenter,
                child: SafeArea(
                  child: HeaderWidget(
                    statusColor: getBackgroundColor(),
                    city: viewModel.selectedCity,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
