
import 'package:blibli_app/model/home_model.dart';
import 'package:flutter/material.dart';

class HomeTabPage extends StatefulWidget {
  final String name;
  final List<BannerMo> bannerList;
  const HomeTabPage({Key key, this.name, this.bannerList}) : super(key: key);
  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(widget.name),
    );
  }
}
