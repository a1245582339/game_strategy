import 'dart:convert';
import 'package:crypto/crypto.dart';

import 'package:app/page/login/login.dart';
import 'package:app/store/index.dart';
import 'package:app/utils/http.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  String _oldPass = '';
  String _newPass = '';
  String _repeatPass = '';

  _validateForm() {
    return _oldPass.length > 0 && _newPass.length > 0 && _repeatPass.length > 0;
  }

  _md5 (password) {
    return md5.convert(Utf8Encoder().convert(password)).toString();
  }

  _submit() async {
    if (!RegExp(r"^[a-zA-Z]\w{5,17}$").hasMatch(_newPass)) {
      BotToast.showText(text: '密码应以字母开头，长度在6~18之间，只能包含字母、数字和下划线');
      return false;
    }
    if (_newPass != _repeatPass) {
      BotToast.showText(text: '两次密码不一致');
      return false;
    }
    final checkPassRes = await Http().put('/client/changePassword',
        auth: true, body: {'password': _md5(_newPass), 'old_password': _md5(_oldPass)});
    if (checkPassRes['code'] == 20003) {
      BotToast.showText(text: '原密码错误，请重试');
    } else {
      BotToast.showText(text: '修改成功，请重新登录');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      Provider.of<Store>(context, listen: false).clearUserInfo();
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return Login();
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('修改密码'),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Form(
              child: Container(
                padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                child: Card(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(15.0, 10.0, 0.0, 0.0),
                        child: TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                              labelText: '请输入原密码',
                              border: InputBorder.none,
                              icon: new Icon(
                                Icons.lock,
                                color: Colors.grey,
                              )),
                          onChanged: (value) {
                            setState(() {
                              _oldPass = value;
                            });
                          },
                        ),
                      ),
                      Divider(
                        height: 1,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(15.0, 10.0, 0.0, 0.0),
                        child: TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: '请输入新密码',
                              icon: new Icon(
                                Icons.lock,
                                color: Colors.grey,
                              )),
                          onChanged: (value) {
                            setState(() {
                              _newPass = value;
                            });
                          },
                        ),
                      ),
                      Divider(
                        height: 1,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(15.0, 10.0, 0.0, 0.0),
                        child: TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: '请输入重复新密码',
                              icon: new Icon(
                                Icons.lock,
                                color: Colors.grey,
                              )),
                          onChanged: (value) {
                            setState(() {
                              _repeatPass = value;
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(35, 30, 35, 0),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 50,
                    width: double.infinity,
                    child: RaisedButton(
                      child: Text('保存'),
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                      disabledColor: Theme.of(context).primaryColorLight,
                      disabledTextColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      onPressed: _validateForm() ? _submit : null,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
