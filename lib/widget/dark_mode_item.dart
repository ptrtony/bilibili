
import 'package:blibli_app/navigator/hi_navigator.dart';
import 'package:blibli_app/provider/theme_provider.dart';
import 'package:blibli_app/utils/view_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class DarkModeItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var themeProvider = context.watch<ThemeProvider>();
    var icon = themeProvider.isDark()?Icons.nightlight_round : Icons.wb_sunny_rounded;
    return InkWell(
      onTap: (){
        HiNavigator.getInstance().onJumpTo(RouteStatus.darkMode);
      },
      child: Container(
        padding: EdgeInsets.only(left: 10,top: 10,bottom: 10),
        child: Row(
          children: [
            Text("夜间模式",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
            Padding(padding: EdgeInsets.only(top: 2,left: 10),child: Icon(icon),)
          ],
        ),
        decoration: BoxDecoration(border:borderLine(context,bottom: true,top: true)),
      ),
    );
  }
}
