


import 'dart:ui';

import 'package:flutter/material.dart';

import 'color.dart';

class LoginInput extends StatefulWidget {
  final String title;
  final String hint;
  final ValueChanged<String> onChanged;
  final ValueChanged<bool> focusChanged;
  final bool lineStretch ;
  final bool obscureText;
  final TextInputType keyboardType;

  const LoginInput(this.title, this.hint,{Key key, this.onChanged, this.focusChanged, this.lineStretch, this.obscureText, this.keyboardType}) : super(key: key);

  @override
  _LoginInputState createState() => _LoginInputState();
}

class _LoginInputState extends State<LoginInput> {
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      print("Has focus ${_focusNode.hasFocus}");
      if(widget.focusChanged!=null){
        widget.focusChanged(_focusNode.hasFocus);
      }
    });

  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 15),
              width: 100,
              child: Text(
                widget.title,
                style: TextStyle(fontSize: 16),
              ),
            ),
            _input()
          ],
        ),
      ],
    );
  }

  _input() {
    return Expanded(child:TextField(
      focusNode: _focusNode,
      onChanged: widget.onChanged,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      autofocus: !widget.obscureText,
      cursorColor: primary,
      style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w300),
      //输入框文本的样式
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 20,right: 20),
        border: InputBorder.none,
        hintText: widget.hint??"",
        hintStyle: TextStyle(fontSize: 15,color: Colors.grey,fontWeight: FontWeight.w300)
      ),
    ));
  }
}

