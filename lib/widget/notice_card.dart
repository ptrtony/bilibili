import 'package:blibli_app/model/home_model.dart';
import 'package:blibli_app/model/notice_mo.dart';
import 'package:blibli_app/navigator/hi_navigator.dart';
import 'package:blibli_app/utils/format_util.dart';
import 'package:blibli_app/utils/view_util.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NoticeCardView extends StatelessWidget {
  final NoticeModel noticeMo;

  const NoticeCardView({Key key, this.noticeMo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onNoticeClick();
      },
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        decoration: BoxDecoration(border: borderLine(context)),
        height: 66,
        child: Row(
          children: [
            _buildIcon(),
            hiSpace(width: 10),
            _buildContent()

          ],
        ),
      ),
    );
  }

  _buildIcon() {
    return noticeMo.type == "video"
        ? Icon(
            Icons.ondemand_video,
            size: 30,
            color: Colors.black,
          )
        : Icon(
            Icons.card_giftcard,
            size: 30,
            color: Colors.black,
          );
  }

  _buildContent() {
    return Flexible(child:  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [_buildTopContent(), _buildBottomContent()],
    ));
  }

  _buildTopContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          noticeMo.title,
          style: TextStyle(fontSize: 20, color: Colors.black87),
        ),
        Container(
          padding: EdgeInsets.only(left: 20, right: 10),
          child: Text(
            dateMonthAndDay(noticeMo.createTime),
            style: TextStyle(color: Colors.black87, fontSize: 16),
          ),
        )
      ],
    );
  }

  _buildBottomContent() {
    return Container(
      padding: EdgeInsets.only(right: 20),
      child: Text(
        noticeMo.subtitle,
        style: TextStyle(fontSize: 16, color: Colors.black87),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  void onNoticeClick() async{
    noticeMo.type == "video" ? HiNavigator.getInstance().onJumpTo(RouteStatus.detail,args: {"videoMo":VideoMo(vid: noticeMo.url)})
        : await canLaunch(noticeMo.url)?launch(noticeMo.url):throw 'Could not launch ${noticeMo.url}';
  }
}
