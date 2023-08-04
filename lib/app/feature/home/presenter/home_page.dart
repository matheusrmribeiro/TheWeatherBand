import 'package:intl/intl.dart';
import 'package:weather_band/app/core/enums.dart';
import 'package:weather_band/app/core/theme/app_colors.dart';
import 'package:weather_band/app/core/widgets/custom_divider_widget.dart';
import 'package:weather_band/app/feature/home/presenter/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:weather_band/app/feature/home/presenter/widgets/forecast_selector_widget.dart';
import 'package:weather_band/app/feature/home/presenter/widgets/header_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final viewModel = Modular.get<HomeViewModel>();

  int? selectedValue;

  String getWeekDayName(int position) {
    final day = DateTime.now().add(Duration(days: position));
    final name = DateFormat("EEEE dd").format(day);
    return name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (BuildContext context, Widget? child) {
          return Container(
            color: AppColors.sunnyColor,
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomDividerWidget(
                    height: 10,
                  ),
                  HeaderWidget(
                    selectedWeekDayPosition: viewModel.position,
                  ),
                  Expanded(child: Container()),
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: ForecastSelectorWidget(
                      currentWeekDay: viewModel.currentWeekDay,
                      selectedWeekDay: viewModel.selectedWeekDay,
                      onChangeDaySelected: (WeekDay value, int position) {
                        viewModel.setWeekDay(value, position);
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
