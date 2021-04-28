import 'package:blibli_app/utils/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final String title;
  final bool enable;
  final VoidCallback onPressed;

  const LoginButton(this.title, {Key key, this.enable = true, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(6))),
        height: 45,
        onPressed: enable ? onPressed : null,
        textColor: primary,
        disabledTextColor: primary[50],
        child: Text(title,style: TextStyle(color: Colors.white,fontSize: 16)),
      ),
    );
  }
}
