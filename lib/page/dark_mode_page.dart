import 'package:blibli_app/provider/theme_provider.dart';
import 'package:blibli_app/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DarkModePage extends StatefulWidget {
  @override
  _DarkModePageState createState() => _DarkModePageState();
}

class _DarkModePageState extends State<DarkModePage> {
  static const _ITEMS = [
    {"name": "跟谁系统", "mode": ThemeMode.system},
    {"name": "开启", "mode": ThemeMode.dark},
    {"name": "关闭", "mode": ThemeMode.light}
  ];

  ThemeMode _currentTheme;

  @override
  void initState() {
    super.initState();
    var themeProvider = context.read<ThemeProvider>();
    ThemeMode themeMode = themeProvider.getThemeMode();
    _ITEMS.forEach((element) {
      if (element["mode"] == themeMode) {
        _currentTheme = themeMode;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("夜间模式"),
      ),
      body: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return _item(index);
          },
          separatorBuilder: (BuildContext context, int index) => Divider(),
          itemCount: _ITEMS.length),
    );
  }

  Widget _item(int index) {
    var theme = _ITEMS[index];
    return InkWell(
      onTap: () {
        _switchTheme(index);
      },
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 16),
        height: 50,
        child: Row(
          children: [
            Expanded(child: Text(theme['name'])),
            Opacity(
              opacity: _currentTheme == theme['mode'] ? 1 : 0,
              child: Icon(
                Icons.done,
                color: primary,
              ),
            )
          ],
        ),
      ),
    );
  }

  void _switchTheme(int index) {
    var theme = _ITEMS[index];
    ThemeMode themeMode = theme['mode'];
    ThemeProvider themeProvider = context.read<ThemeProvider>();
    themeProvider.setThemeMode(themeMode);
    setState(() {
      _currentTheme = themeMode;
    });
  }
}
