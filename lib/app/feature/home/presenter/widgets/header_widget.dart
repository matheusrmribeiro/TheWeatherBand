import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:weather_band/app/core/theme/app_colors.dart';
import 'package:weather_band/app/feature/home/presenter/home_view_model.dart';
import 'package:weather_band/app/feature/search/domain/entities/city_entity.dart';
import 'package:weather_band/app/feature/search/presenter/search_page.dart';

class HeaderWidget extends StatelessWidget {
  HeaderWidget({
    Key? key,
    this.city,
    required this.statusColor,
  }) : super(key: key);

  final CityEntity? city;
  final Color statusColor;

  final viewModel = Modular.get<HomeViewModel>();

  String cityName() {
    String cityName = "Cities";
    if (viewModel.selectedCity != null) {
      cityName =
          "${viewModel.selectedCity!.name}, ${viewModel.selectedCity!.country} ";
    }
    return cityName;
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        HSLColor.fromColor(statusColor).withSaturation(0.8).toColor();

    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          useSafeArea: false,
          builder: (_) {
            return Dialog.fullscreen(
              child: SearchPage(onItemSelected: (value) {
                viewModel.setSelectedCity(value);
              }),
            );
          },
        );
      },
      child: SizedBox(
        width: double.infinity,
        height: 70,
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
                      cityName(),
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
      ),
    );
  }
}
