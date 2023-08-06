import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weather_band/app/core/base/enum/view_model_state.dart';
import 'package:weather_band/app/core/languages/language_utils.dart';
import 'package:weather_band/app/core/theme/app_colors.dart';
import 'package:weather_band/app/core/widgets/custom_divider_widget.dart';
import 'package:weather_band/app/core/widgets/custom_empty_widget.dart';
import 'package:weather_band/app/core/widgets/custom_loading_widget.dart';
import 'package:weather_band/app/feature/search/domain/entities/city_entity.dart';

import '../../../../core/widgets/custom_error_widget.dart';
import 'search_view_model.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({Key? key, required this.onItemSelected})
      : super(key: key);

  final Function(CityEntity) onItemSelected;

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final TextEditingController _textController = TextEditingController();

  final timerListenerDelay = 1500;
  Timer? filterTimer;

  final viewModel = SearchViewModel();

  void onSearch() {
    final text = _textController.text;
    filterTimer?.cancel();
    filterTimer = Timer(Duration(milliseconds: timerListenerDelay), () async {
      viewModel.fetchFromServer(text);
    });
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        HSLColor.fromColor(AppColors.sunnyColor).withSaturation(0.8).toColor();

    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: TextField(
            controller: _textController,
            onChanged: (String? value) {
              onSearch();
            },
            decoration: InputDecoration(
              hintText: LanguageUtils.getString("search_hint"),
              hintStyle: TextStyle(color: Colors.grey[700]),
              fillColor: backgroundColor,
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: AppColors.primaryColor,
                  width: 2.0,
                ),
              ),
            ),
          ),
        ),
        CustomDividerWidget(height: 16),
        Expanded(
          child: ListenableBuilder(
            listenable: viewModel,
            builder: (BuildContext context, Widget? child) {
              Widget widget;
              switch (viewModel.state) {
                case IdleState():
                  {
                    if (viewModel.searchResults.isEmpty) {
                      widget = CustomEmptyWidget(
                          message: LanguageUtils.getString("search_empty"),
                          onRefresh: onSearch);
                    } else {
                      widget = ListView.builder(
                          itemCount: viewModel.searchResults.length,
                          itemBuilder: (_, int index) {
                            final item = viewModel.searchResults[index];
                            return ListTile(
                              title: Text(item.name),
                              subtitle:
                                  Text("${item.state ?? ""} - ${item.country}"),
                              onTap: () {
                                this.widget.onItemSelected(item);
                              },
                              trailing: IconButton(
                                onPressed: () {
                                  viewModel.addBookmark(item);
                                },
                                icon: Icon(Icons.bookmarks, color: AppColors.white,),
                              ),
                            );
                          });
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
                      onRefresh: onSearch,
                    );
                  }
              }

              return widget;
            },
          ),
        )
      ],
    );
  }
}
