import 'package:blibli_app/model/home_model.dart';
import 'package:blibli_app/model/video_detail_mo.dart';
import 'package:blibli_app/utils/color.dart';
import 'package:blibli_app/utils/format_util.dart';
import 'package:blibli_app/utils/view_util.dart';
import 'package:flutter/material.dart';

///视频点赞分享收藏等工具栏
class VideoToolbar extends StatelessWidget {
  final VideoDetailMo videoDetailMo;
  final VideoMo videoMo;
  final VoidCallback onLike;
  final VoidCallback onUnLike;
  final VoidCallback onCoin;
  final VoidCallback onFavorite;
  final VoidCallback onShare;

  const VideoToolbar(
      {Key key,
      @required this.videoDetailMo,
      @required this.videoMo,
      this.onLike,
      this.onUnLike,
      this.onCoin,
      this.onFavorite,
      this.onShare})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15, bottom: 10),
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(border: borderLine(context)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildIconText(Icons.thumb_up_alt_rounded, videoMo.favorite,
              onClick: onLike, tint: videoDetailMo?.isLike),
          _buildIconText(Icons.thumb_down_alt_rounded, "不喜欢",
              onClick: onUnLike),
          _buildIconText(Icons.monetization_on, videoMo.coin, onClick: onCoin),
          _buildIconText(Icons.grade_rounded, videoMo.favorite,
              onClick: onFavorite, tint: videoDetailMo?.isFavorite),
          _buildIconText(Icons.share_rounded, videoMo.share, onClick: onShare)
        ],
      ),
    );
  }

  _buildIconText(IconData iconData, text, {onClick, bool tint: false}) {
    if (text is int) {
      text = formatCount(text);
    } else if (text == null) {
      text = "";
    }
    tint = tint == null ? false : tint;
    return InkWell(
      onTap: onClick,
      child: Column(
        children: [
          Icon(
            iconData,
            color: tint ? primary : Colors.grey,
            size: 20,
          ),
          hiSpace(height: 5),
          Text(
            text,
            style: TextStyle(color: Colors.grey, fontSize: 12),
          )
        ],
      ),
    );
  }
}
