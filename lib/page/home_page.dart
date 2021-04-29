

import 'package:blibli_app/model/video_model.dart';
import 'package:blibli_app/navigator/hi_navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {

  const HomePage({Key key}) : super(key: key);


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var listener;
  @override
  void initState() {
    super.initState();
    HiNavigator.getInstance().addListener(this.listener = (current, pre){
      if(widget == current.page || current.page is HomePage){
        //onResume();
      }else if(widget == pre?.page || pre?.page is HomePage){
        //onPause();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    HiNavigator.getInstance().removeListener(this.listener = (current, pre){

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            Text("首页"),
            MaterialButton(onPressed: (){
              HiNavigator.getInstance().onJumpTo(RouteStatus.detail,args:{'videoMo':VideoModel(1001)});
            }),

          ],
        ),
      ),
    );
  }
}
