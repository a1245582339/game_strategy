import 'package:app/page/userInfo/password.dart';
import 'package:app/store/index.dart';
import 'package:app/utils/http.dart';
import 'package:app/utils/ip.dart';
import 'package:app/utils/userInfo.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:provider/provider.dart';

class UpdateUserInfo extends StatefulWidget {
  @override
  _UpdateUserInfoState createState() => _UpdateUserInfoState();
}

class _UpdateUserInfoState extends State<UpdateUserInfo> {
  String _loginName = '';
  String _nickName = '';
  String _email = '';
  String _avatar = '';

  @override
  void initState() {
    super.initState();
    _getUserInfo(context);
  }

  _getUserInfo(context) async {
    final userInfo = Provider.of<Store>(context, listen: false).getUserInfo;
    print(userInfo);
    setState(() {
      _loginName = userInfo['login_name'];
      _nickName = userInfo['nick_name'];
      _avatar = userInfo['avatar'];
      _email = userInfo['email'];
    });
  }

  bool _validateForm() {
    if (_loginName.length == 0 || _email.length == 0 || _avatar.length == 0) {
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
    BotToast.showLoading();
    final res = await Http().put('/client/user',
        body: {
          'login_name': _loginName,
          'nick_name': _nickName,
          'email': _email,
          'avatar': _avatar
        },
        auth: true);
    print(res);
    Future.delayed(Duration(seconds: 1), () {
      BotToast.closeAllLoading();
      BotToast.showText(text: '保存成功');
      UserInfo(context);
    });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('个人信息'),
        actions: <Widget>[
          MaterialButton(
            child: Text(
              '修改密码',
              style: TextStyle(color: Color(0xcffffffff)),
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
                return ChangePassword();
              }));
            },
          )
        ],
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
                      border: _avatar == null
                          ? Border.all(width: 1, color: Color(0xffeeeeee))
                          : null,
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
                        enabled: false,
                        initialValue: _loginName,
                        decoration: InputDecoration(
                            border: InputBorder.none,
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
                        initialValue: _nickName,
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
                        initialValue: _email,
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
