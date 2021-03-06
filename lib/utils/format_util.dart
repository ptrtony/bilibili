
import 'package:date_format/date_format.dart';

///时间转换将秒转换为分钟:秒
String durationTransform(int seconds){
  int m = (seconds / 60).truncate();
  int s = seconds - m * 60;
  if(s<10){
    return "$m:0$s";
  }
  return "$m:$s";
}



///数字转换为万
String formatCount(int count){
  String views = "";
  if(count > 9999){
    views = "${(count / 10000).toStringAsFixed(2)}万";
  }else{
    views = "$count";
  }
  return views;
}


String dateMonthAndDay(String dateStr) {
  DateTime date = DateTime.parse(dateStr);
  String formatted = formatDate(date, [mm,'-',dd]);
  return formatted;
}



