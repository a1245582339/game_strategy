import 'package:app/page/userInfo/index.dart';
import 'package:app/store/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Setting extends StatelessWidget {
  const Setting({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('设置'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Offstage(
              offstage: Provider.of<Store>(context).getUserInfo['id'] == null,
              child: RaisedButton(
                color: Color(0xFFFDFDFD),
                child: Text('个人信息'),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return UpdateUserInfo();
                  }));
                },
              ),
            ),
            Offstage(
              offstage: Provider.of<Store>(context).getUserInfo['id'] == null,
              child: RaisedButton(
                color: Color(0xFFFDFDFD),
                child: Text('退出登录'),
                onPressed: () {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('确定退出登录？'),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                Text('退出后收藏内容与关注依然会保留'),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            FlatButton(
                                onPressed: () async {
                                  Navigator.of(context).pop();
                                  Provider.of<Store>(context, listen: false).clearUserInfo();
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  await prefs.setString('token', '');
                                },
                                child: Text('确定')),
                            FlatButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('取消')),
                          ],
                        );
                      });
                },
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
