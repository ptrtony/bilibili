import 'package:blibli_app/model/home_model.dart';
import 'package:blibli_app/navigator/hi_navigator.dart';
import 'package:blibli_app/utils/format_util.dart';
import 'package:blibli_app/utils/view_util.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class VideoCard extends StatelessWidget {
  final VideoMo videoMo;

  const VideoCard({Key key, this.videoMo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(videoMo.url);
        HiNavigator.getInstance().onJumpTo(RouteStatus.detail, args: {"videoMo": videoMo});
      },
      child: SizedBox(
        height: 200,
        child: Card(
          margin: EdgeInsets.only(left: 4, right: 4, bottom: 8),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [_itemImage(context), _infoText()],
              )),
        ),
      ),
    );
  }

  _itemImage(BuildContext context) {
    final size = MediaQuery.of(context).size; //容器的宽高设置
    return Stack(
      children: [
        cacheImage(videoMo.cover,width: size.width/2-10,height: 120),
        Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
                padding: EdgeInsets.only(left: 8, right: 8, bottom: 3, top: 5),
                decoration: BoxDecoration(
                    //设置渐变
                    gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [Colors.black54, Colors.transparent])),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _iconText(Icons.ondemand_video, videoMo.view),
                    _iconText(Icons.favorite, videoMo.favorite),
                    _iconText(null, videoMo.duration)
                  ],
                )))
      ],
    );
  }

  _iconText(IconData iconData, int count) {
    String views;
    if (iconData != null) {
      views = formatCount(count);
    } else {
      views = durationTransform(videoMo.duration);
    }
    return Row(
      children: [
        if (iconData != null) Icon(iconData, color: Colors.white, size: 12),
        Text(
          views,
          style: TextStyle(fontSize: 10, color: Colors.white),
        )
      ],
    );
  }

  _infoText() {
    return Expanded(
        child: Padding(
      padding: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            videoMo.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 12, color: Colors.black87),
          ),
          _owner()
        ],
      ),
    ));
  }

  _owner() {
    var owner = videoMo.owner;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              
              child: cacheImage(owner.face,width: 24,height: 24),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text(
                owner.name,
                style: TextStyle(fontSize: 11, color: Colors.black87),
              ),
            )
          ],
        ),
        Icon(
          Icons.more_vert_sharp,
          size: 15,
          color: Colors.grey,
        )
      ],
    );
  }
}
