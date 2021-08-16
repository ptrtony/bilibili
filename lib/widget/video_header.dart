import 'package:blibli_app/model/home_model.dart';
import 'package:blibli_app/utils/color.dart';
import 'package:blibli_app/utils/format_util.dart';
import 'package:blibli_app/utils/toast_util.dart';
import 'package:blibli_app/utils/view_util.dart';
import 'package:flutter/material.dart';

///详情页，作者widget
class VideoHeader extends StatelessWidget {
  final Owner owner;
  const VideoHeader({Key key, @required this.owner}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: cacheImage(owner.face, width: 30, height: 30),
              ),
              Padding(padding: EdgeInsets.only(left: 15)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    owner.name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: primary),
                  ),
                  Text(
                    "${formatCount(owner.fans)}粉丝",
                    style: TextStyle(fontSize: 10, color: Colors.grey[800]),
                  )
                ],
              )
            ],
          ),
          MaterialButton(
            onPressed: () {
              showToast("点击关注 ~~~~");
            },
            color: primary,
            textColor: Colors.white,
            minWidth: 50,
            height: 24,
            child: Text("+ 关注",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
          )
        ],
      ),
    );
  }
}
