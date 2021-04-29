import 'package:blibli_app/http/core/hi_net_error.dart';
import 'package:blibli_app/http/dao/login_dao.dart';
import 'package:blibli_app/navigator/hi_navigator.dart';
import 'package:blibli_app/widget/app_bar.dart';
import 'package:blibli_app/utils/string_util.dart';
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
  bool project = false;
  bool loginEnable = false;
  String userName;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('密码登录', '注册', () {
        HiNavigator.getInstance().onJumpTo(RouteStatus.registration);
      }),
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
    if (isNotEmpty(userName) && isNotEmpty(password)) {
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
        _loginParams();
      },
      child: Text("登录"),
    );
  }

  void _loginParams() {
    if (loginEnable) {
      _login();
    } else {
      print("请输入用户名或密码");
    }
  }

  void _login() async {
    try {
      var result = await LoginDao.login(userName, password);
      if (result['code'] == 0) {
        // print("登录成功");
        HiNavigator.getInstance().onJumpTo(RouteStatus.home);
      }
    } on NeedAuth catch (e) {
      print(e);
    } on HiNetError catch (e) {
      print(e.message);
    }
  }
}
