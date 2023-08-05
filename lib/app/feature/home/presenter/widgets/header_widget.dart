import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:weather_band/app/core/theme/app_colors.dart';
import 'package:weather_band/app/feature/home/presenter/home_view_model.dart';

class HeaderWidget extends StatelessWidget {
  HeaderWidget({
    Key? key,
    required this.cityName,
    required this.statusColor,
  }) : super(key: key);

  final String cityName;
  final Color statusColor;

  final viewModel = Modular.get<HomeViewModel>();

  @override
  Widget build(BuildContext context) {
    final backgroundColor = HSLColor.fromColor(statusColor).withSaturation(0.8).toColor();

    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            color: backgroundColor,
            elevation: 5,
            child: Container(
              height: 60,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    cityName,
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    color: AppColors.white,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
