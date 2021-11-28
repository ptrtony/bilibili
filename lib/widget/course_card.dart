


import 'package:blibli_app/model/profile_mo.dart';
import 'package:blibli_app/provider/theme_provider.dart';
import 'package:blibli_app/utils/view_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class CourseCard extends StatelessWidget {

  final List<CourseList> courseList;
  const CourseCard({Key key, this.courseList}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      child: Column(
        children: [_buildText(context),..._buildCardList(context)],
      ),
    );
  }

  _buildText(BuildContext context) {
    bool isDark = context.watch<ThemeProvider>().isDark();
    return Container(margin: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
    child: Row(children: [
      Text("职场进阶",style: TextStyle(fontSize: 18,color: isDark?Colors.grey:Colors.black),),
      hiSpace(width: 10),
      Text("带您突破技术瓶颈",style: TextStyle(fontSize: 12,color: Colors.grey),)
    ],),);
  }

  _buildCardList(BuildContext context) {
    var courseGroup = Map();
    //将课程进行分组
    courseList.forEach((mo) {
      if(!courseGroup.containsKey(mo.group)){
        courseGroup[mo.group] = [];
      }
      List list = courseGroup[mo.group];
      list.add(mo);
    });

    return courseGroup.entries.map((mo){
      List list = mo.value;
      var width = (MediaQuery.of(context).size.width - 20 - (list.length - 1) * 5) / list.length;
      // var width = (MediaQuery.of(context).size.width - 20 - 5) / 2;
      var height = width / 16 * 6;
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [...list.map((mo) => _buildCard(mo,width,height)).toSet()],
      );
    });
  }

  _buildCard(CourseList mo, double width, double height) {
    return InkWell(
      onTap: (){

      },
      child: Padding(padding: EdgeInsets.only(left: 5,bottom: 7),
      child: ClipRRect(borderRadius: BorderRadius.circular(6),
      child: cacheImage(mo.cover,width: width,height: height),),),
    );
  }
}

