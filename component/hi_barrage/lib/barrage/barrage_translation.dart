


import 'package:flutter/material.dart';

class BarrageTranslation extends StatefulWidget {
  final Duration duration;
  final ValueChanged onCompleted;
  final Widget child;

  const BarrageTranslation({Key key, this.duration, this.onCompleted, this.child}) : super(key: key);
  @override
  BarrageTranslationState createState() => BarrageTranslationState();
}

class BarrageTranslationState extends State<BarrageTranslation> with SingleTickerProviderStateMixin{
  AnimationController _animationController;
  Animation<Offset> _animation;
  @override
  void initState() {
    super.initState();
    //创建动画控制器
    _animationController = AnimationController(duration:widget.duration,vsync: this)
    ..addStatusListener((status) {
      if(status == AnimationStatus.completed){
        widget.onCompleted('');
      }
    });
    //定义从右到左的补间动画
    var begin = Offset(1.0, 0.0);
    var end = Offset(-1.0,0.0);
    _animation = Tween(begin: begin,end: end).animate(_animationController);
    _animationController.forward();
  }
  @override
  Widget build(BuildContext context) {
    return SlideTransition(position: _animation,child: widget.child,);
  }


  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
