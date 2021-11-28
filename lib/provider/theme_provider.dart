import 'package:blibli_app/db/hi_cache.dart';
import 'package:blibli_app/utils/color.dart';
import 'package:blibli_app/utils/hi_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

extension ThemeModelExtension on ThemeMode {
  String get values => <String>["System","Light",  "Dark"][index];
}

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode;
  var _platformBrightness =
      SchedulerBinding.instance?.window?.platformBrightness;

  bool isDark() {
    if (_themeMode == ThemeMode.system) {
      return SchedulerBinding.instance.window.platformBrightness ==
          Brightness.dark;
    }
    return _themeMode == ThemeMode.dark;
  }

  ThemeMode getThemeMode() {
    String theme = HiCache.getInstance().get(HiConstants.theme);
    switch (theme) {
      case "Dark":
        _themeMode = ThemeMode.dark;
        break;
      case "System":
        _themeMode = ThemeMode.system;
        break;
      default:
        _themeMode = ThemeMode.light;
        break;
    }
    return _themeMode;
  }

  void setThemeMode(ThemeMode themeMode) {
    HiCache.getInstance().setString(HiConstants.theme, themeMode.values);
    notifyListeners();
  }

  ThemeData getTheme({bool isDarkMode = false}) {
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

  void darModeChange() {
    if (_platformBrightness !=
        SchedulerBinding.instance?.window?.platformBrightness) {
      _platformBrightness =
          SchedulerBinding.instance?.window?.platformBrightness;
      notifyListeners();
    }
  }
}
