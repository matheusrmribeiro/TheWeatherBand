import 'package:flutter/material.dart';
import 'package:weather_band/app/core/theme/app_colors.dart';
import 'package:weather_band/app/feature/search/domain/entities/city_entity.dart';

class CityListWidget extends StatelessWidget {
  const CityListWidget({
    Key? key,
    required this.items,
    required this.onItemSelected,
    required this.onActionCallback,
    required this.icon,
  }) : super(key: key);

  final List<CityEntity> items;
  final Icon icon;
  final Function(CityEntity) onItemSelected;
  final Function(CityEntity) onActionCallback;

  String subtitle(CityEntity item) {
    String subtitle = item.state ?? "";
    if (subtitle.isNotEmpty)
      subtitle += " - ";
    subtitle += item.country;
    return subtitle;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (_, int index) {
          final item = items[index];
          return ListTile(
            title: Text(
              item.name,
              style: const TextStyle(
                color: AppColors.greyTransparent,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              subtitle(item),
              style: const TextStyle(
                color: AppColors.greyTransparent,
                fontWeight: FontWeight.w600,
              ),
            ),
            onTap: () {
              onItemSelected(item);
            },
            trailing: IconButton(
              onPressed: () {
                onActionCallback(item);
              },
              icon: icon,
            ),
          );
        });
  }
}
