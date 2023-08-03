import 'package:weather_band/app/core/languages/language_utils.dart';
import 'package:weather_band/app/core/routes.dart';
import 'package:weather_band/app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_band/app/core/widgets/custom_divider_widget.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  SharedPreferences prefs = Modular.get<SharedPreferences>();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 2000), () {
      Modular.to.navigate(ROUTE_INITIAL);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.sunnyColor,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              LanguageUtils.getString("splash_name"),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 24,
                color: AppColors.white,
              ),
            ),
            CustomDividerWidget(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: LinearProgressIndicator(color: AppColors.primaryColor),
            )
          ],
        ),
      ),
    );
  }
}
