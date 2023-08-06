import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_band/app/core/theme/app_colors.dart';
import 'package:weather_band/app/core/widgets/custom_divider_widget.dart';

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({Key? key, required this.message})
      : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.sunnyColor,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset("assets/images/loading_weather.svg",
              height: 100,
              width: 100,
              alignment: Alignment.center,
              semanticsLabel: "loading"),
          CustomDividerWidget(height: 15),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.white,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
