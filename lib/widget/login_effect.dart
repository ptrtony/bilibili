import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

///登录动效，自定义
class LoginEffect extends StatefulWidget {
  final bool project;

  const LoginEffect({Key key, @required this.project}) : super(key: key);

  @override
  _LoginEffectState createState() => _LoginEffectState();
}

class _LoginEffectState extends State<LoginEffect> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          color: Colors.grey[100],
          border: Border(bottom: BorderSide(color: Colors.grey[300]))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _image(true),
          Image(
            height: 90,
            width: 90,
            image: AssetImage("images/logo"),
          ),
          _image(false)
        ],
      ),
    );
  }

  _image(bool left) {
    var leftImage =
        widget.project ? "images/head_left_project" : "images/head_left";
    var rightImage =
        widget.project ? "images/head_right_project" : "images/head_right";
    return Image(height: 90, image: AssetImage(left ? leftImage : rightImage));
  }
}
