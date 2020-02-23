import 'dart:convert';

import 'package:app/utils/http.dart';
import 'package:app/utils/ip.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:crypto/crypto.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String _loginName = '';
  String _nickName = '';
  String _email = '';
  String _password = '';
  String _repeatPassword = '';
  String _avatar;

  bool _validateForm() {
    if (_loginName.length == 0 ||
        _email.length == 0 ||
        _password.length == 0 ||
        _avatar.length == 0) {
      return false;
    } else {
      return true;
    }
  }

  void _selectAndUploadAvatar() async {
    final image = await ImagePicker.pickImage(source: ImageSource.gallery);
    String path = image.path;
    final name = path.substring(path.lastIndexOf("/") + 1, path.length);
    FormData formData = FormData.fromMap(
        {"file": await MultipartFile.fromFile(image.path, filename: name)});
    Dio dio = Dio();
    final response =
        await dio.post(Ip.host + '/api/v1/upload/avatar', data: formData);
    setState(() {
      _avatar = response.data['path'];
    });
  }

  Future<bool> handleTapRegister() async {
    if (!RegExp(r"(^\w{3,20}$)").hasMatch(_loginName)) {
      BotToast.showText(text: '登录名应为长度为3-20，由数字、26个英文字母或者下划线组成');
      return false;
    }
    if (!RegExp(r"(^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$)")
        .hasMatch(_email)) {
      BotToast.showText(text: '邮箱格式错误');
      return false;
    }
    if (!RegExp(r"^[a-zA-Z]\w{5,17}$").hasMatch(_password)) {
      BotToast.showText(text: '密码应以字母开头，长度在6~18之间，只能包含字母、数字和下划线');
      return false;
    }
    if (_password != _repeatPassword) {
      BotToast.showText(text: '两次密码不一致');
      return false;
    }
    final checkLoginNameRes =
        await Http().get('/client/check', params: {'login_name': _loginName});
    if (checkLoginNameRes['data']['exist']) {
      BotToast.showText(text: '登录名已存在，换一个试试吧');
      return false;
    }
    final createRes = await Http().post('/client/user', body: {
      'login_name': _loginName,
      'nick_name': _nickName,
      'email': _email,
      'password': md5.convert(Utf8Encoder().convert(_password)).toString(),
      'avatar': _avatar
    });
		if (createRes['code'] == 40009) {
			BotToast.showText(text: '登录名已存在，换一个试试吧');
			return false;
		} else {
			BotToast.showText(text: '注册成功，前往登录吧~');
			Navigator.of(context).pop();
			return true;
		}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('注册'),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.fromLTRB(0, 50, 0, 50),
              child: Center(
                child: GestureDetector(
                  child: Container(
                    height: 100,
                    width: 100,
                    child: _avatar == null
                        ? Icon(Icons.add_a_photo)
                        : CircleAvatar(
                            backgroundImage: NetworkImage(_avatar),
                          ),
                    decoration: BoxDecoration(
                      border: _avatar == null ? Border.all(width: 1, color: Color(0xffeeeeee)) : null,
                    ),
                  ),
                  onTap: _selectAndUploadAvatar,
                ),
              )),
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
                            _loginName = value;
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
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: '请输入昵称',
                            icon: new Icon(
                              Icons.person,
                              color: Colors.grey,
                            )),
                        onChanged: (value) {
                          setState(() {
                            _nickName = value;
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
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: '请输入电子邮箱',
                            icon: new Icon(
                              Icons.mail,
                              color: Colors.grey,
                            )),
                        onChanged: (value) {
                          setState(() {
                            _email = value;
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
                            _password = value;
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
                            labelText: '请重复密码',
                            icon: new Icon(
                              Icons.lock_outline,
                              color: Colors.grey,
                            )),
                        onChanged: (value) {
                          setState(() {
                            _repeatPassword = value;
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
                  child: RaisedButton(
                    child: Text('注册'),
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                    disabledColor: Theme.of(context).primaryColorLight,
                    disabledTextColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    onPressed: _validateForm() ? handleTapRegister : null,
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
