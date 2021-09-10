import 'package:blibli_app/utils/view_util.dart';
import 'package:flutter/material.dart';

class HiFlexibleHeader extends StatefulWidget {
  final String name;
  final String face;
  final ScrollController controller;

  const HiFlexibleHeader(
      {Key key,
      @required this.name,
      @required this.face,
      @required this.controller})
      : super(key: key);

  @override
  _HiFlexibleHeaderState createState() => _HiFlexibleHeaderState();
}

class _HiFlexibleHeaderState extends State<HiFlexibleHeader> {
  static const double MAX_BOTTOM = 40;
  static const double MIN_BOTTOM = 10;
  double _byBottom = MAX_BOTTOM;

  static const double MAX_OFFSET = 80;
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      var offset = widget.controller.offset;
      var byOffset = (MAX_OFFSET - offset) / MAX_OFFSET;
      var dy = byOffset * (MAX_BOTTOM - MIN_BOTTOM);
      if (dy > MAX_BOTTOM - MIN_BOTTOM) {
        dy = MAX_BOTTOM - MIN_BOTTOM;
      } else if (dy < 0) {
        dy = 0;
      }

      setState(() {
        _byBottom = MIN_BOTTOM + dy;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30, bottom: _byBottom),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: cacheImage(widget.face, width: 48, height: 48),
          ),
          hiSpace(width: 10),
          Text(
            widget.name,
            style: TextStyle(fontSize: 14,color: Colors.black38),
          )
        ],
      ),
    );
  }
}
