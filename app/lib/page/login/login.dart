import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:bot_toast/bot_toast.dart';
import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/http.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String loginName = '';
  String password = '';
  bool _validateForm() {
    if (loginName.length == 0 || password.length == 0) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('登录'),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0, 50, 0, 50),
            child: Image.asset('lib/assets/flutter-logo.png', height: 100),
          ),
          Form(
            child: Container(
              padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
              child: Card(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(15.0, 10.0, 0.0, 0.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: '请输入登录名',
                            icon: new Icon(
                              Icons.person_pin,
                              color: Colors.grey,
                            )),
                        onChanged: (value) {
                          setState(() {
                            loginName = value;
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
                            labelText: '请输入密码',
                            icon: new Icon(
                              Icons.lock,
                              color: Colors.grey,
                            )),
                        onChanged: (value) {
                          setState(() {
                            password = value;
                          });
                        },
                      ),
                    ),
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
                  child: OutlineButton(
                    child: Text('注册'),
                    textColor: Theme.of(context).primaryColor,
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    onPressed: () {},
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  child: RaisedButton(
                    child: Text('登录'),
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                    disabledColor: Theme.of(context).primaryColorLight,
                    disabledTextColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    onPressed: _validateForm()
                        ? () async {
                            // BotToast.showLoading();
                            final res = await Http().post('/auth/client/login',
                                body: {"login_name": loginName, "password": md5.convert(Utf8Encoder().convert(password)).toString()});
                            if (res['code'] == 40001) {
                                Future.delayed(Duration(seconds: 1), () {
                                    BotToast.closeAllLoading();
                                    BotToast.showText(text: '登录名或密码错误，请重试');
                                });
                            } else {
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                await prefs.setString('token', res['token']);
                                Future.delayed(Duration(seconds: 1), () {
                                    BotToast.showText(text: '登录成功，欢迎回来～');
                                    BotToast.closeAllLoading();
                                    Navigator.of(context).pop();
                                });
                            }
                          }
                        : null,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
