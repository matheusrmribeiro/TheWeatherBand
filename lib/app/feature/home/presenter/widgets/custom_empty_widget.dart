import 'package:flutter/material.dart';
import 'package:weather_band/app/core/languages/language_utils.dart';
import 'package:weather_band/app/core/theme/app_colors.dart';
import 'package:weather_band/app/core/widgets/custom_divider_widget.dart';

class CustomEmptyWidget extends StatelessWidget {
  const CustomEmptyWidget({Key? key, required this.onRefresh}) : super(key: key);

  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.sunnyColor,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.list_alt,
            size: 50,
            color: AppColors.white,
          ),
          CustomDividerWidget(height: 15),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              LanguageUtils.getString("empty_data"),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.white,
                fontSize: 16,
              ),
            ),
          ),
          TextButton(
            onPressed: onRefresh,
            child: Text(LanguageUtils.getString("reload")),
          )
        ],
      ),
    );
  }
}
