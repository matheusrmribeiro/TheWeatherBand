import 'package:flutter/material.dart';
import 'package:weather_band/app/core/languages/language_utils.dart';
import 'package:weather_band/app/core/theme/app_colors.dart';
import 'package:weather_band/app/feature/search/domain/entities/city_entity.dart';
import 'package:weather_band/app/feature/search/presenter/bookmark/bookmark_widget.dart';

import 'search/search_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key, required this.onItemSelected}) : super(key: key);

  final Function(CityEntity) onItemSelected;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.sunnyColor,
        appBar: AppBar(
          title: Text(LanguageUtils.getString("search")),
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          bottom: TabBar(
            tabs: [
              Tab(
                text: LanguageUtils.getString("search_tab_bookmark"),
              ),
              Tab(
                text: LanguageUtils.getString("search_tab_search"),
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            BookmarkedWidget(
              onItemSelected: widget.onItemSelected,
            ),
            SearchWidget(
              onItemSelected: widget.onItemSelected,
            )
          ],
        ),
      ),
    );
  }
}
