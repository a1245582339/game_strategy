/* 
  登录页
*/
import 'package:app/page/login/register.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:bot_toast/bot_toast.dart';
import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/http.dart';
import '../../utils/userInfo.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String loginName = ''; // 用户名
  String password = ''; // 密码
  bool _validateForm() {    // 检查用户名和密码是否都已填写的方法
    if (loginName.length == 0 || password.length == 0) {  // 如果用户名和密码有一个未填写，则返回false，按钮不可点击
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(   // 头部bar
        title: Text('登录'),    // 标题
      ),
      body: ListView(
        children: <Widget>[
          Padding( 
            padding: EdgeInsets.fromLTRB(0, 50, 0, 50),
            child: Image.asset('lib/assets/flutter-logo.png', height: 100),   // 登录页的图片
          ),
          Form(   // 表单内容
            child: Container(
              padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
              child: Card(    // 表单的卡片组件
                child: Column(    
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(15.0, 10.0, 0.0, 0.0),
                      child: TextFormField(   // 登录的输入框
                        decoration: InputDecoration(
                            border: InputBorder.none,   // 无边框
                            labelText: '请输入登录名',   // 未输入内容时的文案
                            icon: new Icon(   // 用户名左侧的图标
                              Icons.person_pin,
                              color: Colors.grey,   // 图标灰色
                            )),
                        onChanged: (value) {    // 内容发生改变时，更新一下页面的用户名状态
                          setState(() {
                            loginName = value;
                          });
                        },
                      ),
                    ),
                    Divider(    // 分割线
                      height: 1,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(15.0, 10.0, 0.0, 0.0),
                      child: TextFormField(   // 输入框
                        obscureText: true,  // 密码模式，输入时会变成圆点
                        decoration: InputDecoration(    
                            border: InputBorder.none,
                            labelText: '请输入密码',    // 未输入时的默认文案
                            icon: new Icon(
                              Icons.lock,
                              color: Colors.grey,
                            )),
                        onChanged: (value) {   // 内容发生改变时，更新一下页面的密码状态
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
          Container(    // 按钮组
            padding: const EdgeInsets.fromLTRB(35, 30, 35, 0),
            child: Column(
              children: <Widget>[
                Container(
                  height: 50,
                  width: double.infinity,
                  child: OutlineButton(		// 注册按钮
                    child: Text('注册'),
                    textColor: Theme.of(context).primaryColor,
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    onPressed: () {		// 点击时事件
                      Navigator.of(context).pushReplacement(		// 跳转至注册页面
                          MaterialPageRoute(builder: (context) {
                        return Register();		// 注册页面
                      }));
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  child: RaisedButton(		// 登录按钮
                    child: Text('登录'),
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                    disabledColor: Theme.of(context).primaryColorLight,
                    disabledTextColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    onPressed: _validateForm()		// 如果用户名和密码都输入了，点击事件为发起登录，否则为null，按钮无法点击
                        ? () async {
                            BotToast.showLoading();		// loading，避免重复点击
                            final res =
                                await Http().post('/auth/client/login', body: {
                              "login_name": loginName,
                              "password": md5
                                  .convert(Utf8Encoder().convert(password))
                                  .toString()		// 发起请求
                            });
                            if (res['code'] == 40001) {		// 如果返回的code为40001说明用户名密码错误
                              Future.delayed(Duration(seconds: 1), () {		// 延迟一秒，避免请求过快
                                BotToast.closeAllLoading();		// 关闭loading
                                BotToast.showText(text: '登录名或密码错误，请重试');	// 弹出提示
                              });
                            } else {		// 如果不是40001，说明用户名密码正确
                              SharedPreferences prefs =		
                                  await SharedPreferences.getInstance();	// 拿到本地存储实例
                              await prefs.setString('token', res['token']);	// 把token存到本地，持久化存储，下次打开应用自动登录
                              UserInfo(context);	// 调用用户信息接口，获取用户信息
                              Future.delayed(Duration(seconds: 1), () {		// 延迟一秒
                                BotToast.showText(text: '登录成功，欢迎回来～');	// toast
                                BotToast.closeAllLoading();		// 关闭loading
                                Navigator.of(context).pop();	// 返回上一级页面
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
