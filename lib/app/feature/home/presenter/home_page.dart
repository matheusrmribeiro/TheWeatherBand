import 'package:intl/intl.dart';
import 'package:weather_band/app/core/constants.dart';
import 'package:weather_band/app/core/enums.dart';
import 'package:weather_band/app/core/theme/app_colors.dart';
import 'package:weather_band/app/core/widgets/custom_divider_widget.dart';
import 'package:weather_band/app/feature/home/presenter/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:weather_band/app/feature/home/presenter/weather_day_page.dart';
import 'package:weather_band/app/feature/home/presenter/widgets/custom_empty_widget.dart';
import 'package:weather_band/app/feature/home/presenter/widgets/forecast_selector_widget.dart';
import 'package:weather_band/app/feature/home/presenter/widgets/header_widget.dart';
import 'package:weather_band/app/feature/home/presenter/widgets/weather_widget.dart';

import 'widgets/custom_error_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final viewModel = Modular.get<HomeViewModel>();

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: FORECAST_TRACKING_DAYS, vsync: this);
    viewModel.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (BuildContext context, Widget? child) {
          if (viewModel.hasError) {
            return CustomErrorWidget();
          }
          if (viewModel.weekDayList.isEmpty) {
            return CustomEmptyWidget();
          } else {
            return WeatherWidget(
              tabController: _tabController,
              weekDayList: viewModel.weekDayList,
            );
          }
        },
      ),
    );
  }
}
