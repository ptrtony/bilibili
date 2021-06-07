import 'dart:ffi';

import 'package:blibli_app/http/core/hi_net_error.dart';
import 'package:blibli_app/http/dao/login_dao.dart';
import 'package:blibli_app/navigator/hi_navigator.dart';
import 'package:blibli_app/utils/toast_util.dart';
import 'package:blibli_app/widget/app_bar.dart';
import 'package:blibli_app/utils/string_util.dart';
import 'package:blibli_app/widget/login_button.dart';
import 'package:blibli_app/widget/login_effect.dart';
import 'package:blibli_app/widget/login_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {

  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();

}

class _LoginPageState extends State<LoginPage> {
  var listener;
  bool protect = false;
  bool loginEnable = false;
  String userName;
  String password;

  @override
  void initState() {
    super.initState();
    HiNavigator.getInstance().addListener(this.listener = (current,pre){

      if(widget == current.page || current.page is LoginPage){

      }else if(widget == pre?.page || pre?.page is LoginPage){

      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    HiNavigator.getInstance().removeListener(this.listener);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('密码登录', '注册', () {
        HiNavigator.getInstance().onJumpTo(RouteStatus.registration);
      }),
      body: Container(
        child: ListView(
          children: [
            LoginEffect(project: protect),
            LoginInput(
              "用户名",
              "请输入姓名",
              lineStretch: false,
              obscureText: false,
              onChanged: (text) {
                userName = text;
                _checkLogin();
              },
              // focusChanged: (focus) {
              //     setState(() {
              //       protect = false;
              //     });
              //   },
            ),
            LoginInput(
              "密码",
              "请输入密码",
              lineStretch: true,
              obscureText: true,
              onChanged: (text) {
                password = text;
                _checkLogin();
              },
              focusChanged: (focus) {
                setState(() {
                  protect = focus;
                });
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 20,left: 20,right: 20),
              child: LoginButton("登录",enable: loginEnable,onPressed: (){
                send();
              },),
            )
          ],
        ),
      ),
    );
  }

  void _checkLogin() {
    bool enable;
    if (isNotEmpty(userName) && isNotEmpty(password)) {
      enable = true;
    } else {
      enable = false;
    }
    setState(() {
      loginEnable = enable;
    });
  }

  send() async{
    try {
      var result = await LoginDao.login(userName, password);
      if (result['code'] == 0) {
        showToast("登录成功");
        HiNavigator.getInstance().onJumpTo(RouteStatus.home);
      }else{
        showWarnToast("登录失败");
      }
    } on NeedAuth catch (e) {
      print(e);
      showWarnToast("登录失败");
    } on HiNetError catch (e) {
      print(e.message);
      showWarnToast("登录失败");
    }catch(e){
      showWarnToast("登录失败:" + e.toString());
    }
  }
}
