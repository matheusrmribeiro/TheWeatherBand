import 'package:flutter/material.dart';
import 'package:weather_band/app/core/base/enum/view_model_state.dart';
import 'package:weather_band/app/core/languages/language_utils.dart';
import 'package:weather_band/app/core/theme/app_colors.dart';
import 'package:weather_band/app/core/widgets/custom_divider_widget.dart';
import 'package:weather_band/app/core/widgets/custom_empty_widget.dart';
import 'package:weather_band/app/core/widgets/custom_loading_widget.dart';
import 'package:weather_band/app/feature/search/domain/entities/city_entity.dart';
import 'package:weather_band/app/feature/search/presenter/bookmark/bookmark_view_model.dart';

import '../../../../core/widgets/custom_error_widget.dart';

class BookmarkedWidget extends StatefulWidget {
  const BookmarkedWidget({Key? key, required this.onItemSelected})
      : super(key: key);

  final Function(CityEntity) onItemSelected;

  @override
  State<BookmarkedWidget> createState() => _BookmarkedWidgetState();
}

class _BookmarkedWidgetState extends State<BookmarkedWidget> {
  final viewModel = BookmarkViewModel();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() {
    viewModel.fetchBookmarks();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomDividerWidget(height: 16),
        Expanded(
          child: ListenableBuilder(
            listenable: viewModel,
            builder: (BuildContext context, Widget? child) {
              Widget widget;
              switch (viewModel.state) {
                case IdleState():
                  {
                    if (viewModel.bookmarks.isEmpty) {
                      widget = CustomEmptyWidget(
                        message:
                            LanguageUtils.getString("search_bookmark_empty"),
                      );
                    } else {
                      widget = ListView.builder(
                          itemCount: viewModel.bookmarks.length,
                          itemBuilder: (_, int index) {
                            final item = viewModel.bookmarks[index];
                            return ListTile(
                              title: Text(item.name),
                              subtitle:
                                  Text("${item.state ?? ""} - ${item.country}"),
                              onTap: () {
                                this.widget.onItemSelected(item);
                              },
                              trailing: IconButton(
                                onPressed: () {
                                  viewModel.removeBookmark(item);
                                },
                                icon: Icon(Icons.delete, color: AppColors.white),
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
                      onRefresh: fetchData,
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
