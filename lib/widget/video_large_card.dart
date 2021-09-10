import 'package:blibli_app/model/home_model.dart';
import 'package:blibli_app/navigator/hi_navigator.dart';
import 'package:blibli_app/utils/format_util.dart';
import 'package:blibli_app/utils/view_util.dart';
import 'package:flutter/material.dart';

class VideoLargeCard extends StatefulWidget {
  final VideoMo videoMo;

  const VideoLargeCard({Key key, this.videoMo}) : super(key: key);

  @override
  _VideoLargeCardState createState() => _VideoLargeCardState();
}

class _VideoLargeCardState extends State<VideoLargeCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HiNavigator.getInstance()
            .onJumpTo(RouteStatus.detail, args: {'videoMo': widget.videoMo});
      },
      child: Container(
        height: 106,
        margin: EdgeInsets.only(left: 15,right: 15,bottom: 5),
        decoration: BoxDecoration(border: borderLine(context)),
        child: Row(
          children: [
            _itemImage(context),
            _buildContent()
          ],
        ),
      ),
    );
  }

  _itemImage(BuildContext context) {
    var height = 90.0;
    return ClipRRect(
      borderRadius: BorderRadius.circular(3),
      child: Stack(
        children: [
          cacheImage(widget.videoMo.cover,
              height: height, width: height * 16 / 9),
          Positioned(
              right: 5,
              bottom: 5,
              child: Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Text(
                  durationTransform(widget.videoMo.duration),
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ))
        ],
      ),
    );
  }

  _buildContent() {
    return Expanded(child: Container(
      padding: EdgeInsets.only(top: 10,left: 8,bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.videoMo.title,style: TextStyle(color: Colors.black87,fontSize: 12),maxLines: 2,overflow: TextOverflow.ellipsis,),

          Column(
            children: [
              _owner(),
              _buildBottomContent()
            ],
          )
        ],
      ),
    ));
  }

  _owner() {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(1)),
            border: Border.all(color: Colors.grey,width: .5)
          ),
          child: Text("UP",style: TextStyle(color: Colors.grey,fontSize: 8,fontWeight:FontWeight.bold),)
        ),
        hiSpace(width: 8),
        Text(widget.videoMo.owner.name,style: TextStyle(color: Colors.grey,fontSize: 11),)
      ],
    );
  }

  _buildBottomContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(children: [
          ...smallIconText(Icons.ondemand_video, widget.videoMo.view),
          hiSpace(width: 5),
          ...smallIconText(Icons.list_alt, widget.videoMo.reply)
        ],),
        Icon(Icons.more_vert,size: 20,color: Colors.grey,)
      ],
    );
  }
}
