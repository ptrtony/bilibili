import 'package:blibli_app/http/core/hi_net_error.dart';
import 'package:blibli_app/http/dao/login_dao.dart';
import 'package:blibli_app/navigator/hi_navigator.dart';
import 'package:blibli_app/utils/string_util.dart';
import 'package:blibli_app/widget/login_effect.dart';
import 'package:blibli_app/widget/login_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool project = false;
  bool loginEnable = false;
  String userName;
  String password;
  String rePassword;
  String imooocId;
  String orderId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            LoginEffect(project: project),
            LoginInput(
              "用户名",
              "请输入姓名",
              onChanged: (text) {
                userName = text;
                _checkLogin();
              },
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
                  project = focus;
                });
              },
            ),
            LoginInput(
              "重新输入密码",
              "请重新输入密码",
              obscureText: true,
              onChanged: (text) {
                rePassword = text;
                _checkLogin();
              },
              focusChanged: (focus) {
                setState(() {
                  project = focus;
                });
              },
            ),
            LoginInput(
              "慕课网ID",
              "请输入慕课网ID",
              keyboardType: TextInputType.number,
              onChanged: (text) {
                rePassword = text;
                _checkLogin();
              },
              focusChanged: (focus) {
                setState(() {
                  project = focus;
                });
              },
            ),
            LoginInput(
              "订单ID",
              "请输入订单ID",
              keyboardType: TextInputType.number,
              onChanged: (text) {
                rePassword = text;
                _checkLogin();
              },
              focusChanged: (focus) {
                setState(() {
                  project = focus;
                });
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: _loginButton(),
            )
          ],
        ),
      ),
    );
  }

  void _checkLogin() {
    bool enable;
    if (isNotEmpty(userName) &&
        isNotEmpty(password) &&
        isNotEmpty(rePassword) &&
        isNotEmpty(imooocId) &&
        isNotEmpty(orderId)) {
      enable = true;
    } else {
      enable = false;
    }

    setState(() {
      loginEnable = enable;
    });
  }

  _loginButton() {
    return InkWell(
      onTap: () {
        if (loginEnable) {
          _checkParams();
        } else {
          print("loginEnable is false");
        }
      },
      child: Text("注册"),

    );
  }

  void _send() async {
    try {
      var result =
          await LoginDao.registration(userName, password, imooocId, orderId);
      print(result);
      if (result["code"] == 0) {
        print("注册成功");
        HiNavigator.getInstance().onJumpTo(RouteStatus.login);
      }
    } on NeedAuth catch (e) {
      print(e);
    } on HiNetError catch (e) {
      print(e.message);
    }
  }

  void _checkParams() {
    String tips;
    if(password != rePassword){
      tips = "两次输入的密码不一致";
    }
    if(orderId.length != 4){
      tips = "请输入订单号后四位";
    }
    if(isNotEmpty(tips)){
      print(tips);
      return;
    }
    _send();
  }
}
