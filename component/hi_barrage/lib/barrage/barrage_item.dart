
import 'package:flutter/material.dart';

import 'barrage_translation.dart';

class BarrageItem extends StatelessWidget {
  final String id;
  final double top;
  final Widget child;
  final ValueChanged<String> onCompleted;
  final Duration duration;

  BarrageItem(
      {Key key,
      this.id,
      this.top,
      this.onCompleted,
      this.child,
      this.duration = const Duration(milliseconds: 9000)})
      : super(key: key);

  //fix 动画错乱状态
  var _key = GlobalKey<BarrageTranslationState>();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
        top: top,
        child: BarrageTranslation(
          key: _key,
          duration: duration,
          onCompleted: (v) {
            onCompleted(id);
          },
          child: child,
        ));
  }
}
