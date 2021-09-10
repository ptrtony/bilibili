import 'package:blibli_app/db/hi_cache.dart';
import 'package:blibli_app/utils/color.dart';
import 'package:blibli_app/utils/hi_constants.dart';
import 'package:flutter/material.dart';

extension ThemeModelExtension on ThemeMode {
  String get values => <String>["Dark", "System", "Light"][index];
}

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode;

  ThemeMode getThemeMode() {
    String theme = HiCache.getInstance().get(HiConstants.theme);
    switch (theme) {
      case "Dark":
        _themeMode = ThemeMode.dark;
        break;
      case "Light":
        _themeMode = ThemeMode.light;
        break;
      default:
        _themeMode = ThemeMode.system;
        break;
    }
    return _themeMode;
  }


  void setThemeMode(ThemeMode themeMode){
    HiCache.getInstance().setString(HiConstants.theme, themeMode.values);
    notifyListeners();
  }

  ThemeData getTheme({bool isDarkMode = false}){
    var themeMode = ThemeData(
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      errorColor: isDarkMode ? HiColor.dark_red : HiColor.red,
      primaryColor: isDarkMode ? HiColor.dark_bg : white,
      accentColor: isDarkMode ? primary[50] : white,
      //tab指示器的颜色
      indicatorColor: isDarkMode ? primary[50] : Colors.white,
      //页面主题色
      scaffoldBackgroundColor: isDarkMode ? HiColor.dark_bg : white,
    );

    return themeMode;
  }
}
