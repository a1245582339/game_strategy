import 'dart:async';

import 'package:app/component/appBar/home.dart';
import 'package:app/component/appBar/notice.dart';
import 'package:app/component/appBar/category.dart';
import 'package:app/page/favorites/index.dart';
import 'package:app/page/follow/index.dart';
import 'package:app/page/login/register.dart';
import 'package:app/page/setting/index.dart';
import 'package:app/utils/http.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bot_toast/bot_toast.dart';
import './store/index.dart';
import './page/home/index.dart';
import './page/notice/index.dart';
import './page/category/index.dart';
import './utils/userInfo.dart';
import 'page/login/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Store(),
        )
      ],
      child: Consumer<Store>(
        builder: (context, store, _) {
          return BotToastInit(
            child: MaterialApp(
              title: 'Flutter Demo',
              navigatorObservers: [BotToastNavigatorObserver()],
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: MyHomePage(title: 'Flutter Demo Home Page'),
            ),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  List<Widget> pages = [];
  List<Widget> appBar = [];
  int _unreadCount = 0;
  @override
  void initState() {
    super.initState();
    appBar..add(HomeBar())..add(CategoryBar())..add(NoticeBar()); // 三个页面的顶部栏
    pages..add(Home())..add(Category())..add(Notice()); // 对应三个页面
    UserInfo(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getUnread(); // 获取评论的未读数
  }

  _getUnread() async {
    // 获取未读的数量
    if (Provider.of<Store>(context, listen: false).getUserInfo['id'] == null) { // 如果是未登录状态，则什么都不做
      return false;
    }
    final countRes = await Http().get('/comment/unread', auth: true); // 获取未读数
    print(countRes);
    if (_unreadCount != countRes['count']) {  // 如果新拿到的未读数和之前的未读数不一样，则更新页面的未读数
      setState(() {
        _unreadCount = countRes['count'];
      });
    }
    Timer(Duration(seconds: 10), () { // 每十秒请求一次
      _getUnread();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar[_currentIndex],    // 顶部栏，根据页面的index进行切换
      body: pages[_currentIndex],   // 页面主体内容，切换原理同上
      bottomNavigationBar: BottomNavigationBar(   // 底部tab
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('首页')),   // 首页的tab
            BottomNavigationBarItem(    // 分类页的tab
                icon: Icon(Icons.category), title: Text('分类')),
            _unreadCount != 0   // 如果未读数是0，则展示普通状态的tab，如果有未读数，则展示带红点的tab
                ? BottomNavigationBarItem(
                    icon: Badge(
                      badgeContent: Text(
                        _unreadCount > 99 ? '...' : _unreadCount.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                      child: Icon(Icons.notifications),
                    ),
                    title: Text('通知'))
                : BottomNavigationBarItem(
                    icon: Icon(Icons.notifications), title: Text('通知')),
          ],
          currentIndex: _currentIndex,  // 当前页面的index，默认是0，也就是首页
          onTap: (int index) {  // 点击底部栏的时候切换tab
            setState(() {
              _currentIndex = index;
            });
          }),
      drawer: Drawer(   // 侧边栏
        child: ListView(  
          padding: EdgeInsets.zero,   // 填满手机顶部状态栏
          children: <Widget>[
            Provider.of<Store>(context).getUserInfo['id'] != null   // 当用户未登录的时候展示登录注册按钮，已登录时展示用户信息
                ? UserAccountsDrawerHeader(   // 展示用户信息的卡片
                    accountName: Text(Provider.of<Store>(context)   // 用户名
                            .getUserInfo['nick_name'] ??
                        Provider.of<Store>(context).getUserInfo['login_name']),
                    accountEmail:                                 // 邮箱
                        Text(Provider.of<Store>(context).getUserInfo['email']),
                    currentAccountPicture: CircleAvatar(            // 头像
                      backgroundImage: NetworkImage(
                          Provider.of<Store>(context).getUserInfo['avatar']),
                    ),
                  )
                : DrawerHeader(                   // 未登录的时候展示一些文案和登录注册按钮
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Column(                
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(           // 文案1
                            '登录后有新天地',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Text('让你体验私人定制',        // 文案2
                              style: TextStyle(color: Color(0xFF666666))),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: 110,
                                child: OutlineButton(     // 注册按钮，点击跳转注册页面
                                  child: Text('注册'),
                                  textColor: Theme.of(context).primaryColor,
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor,
                                      width: 1),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  onPressed: () async {   // 点击事件，点击时跳转
                                    await Future.delayed(
                                        Duration(milliseconds: 200), () {   // 延迟200毫秒
                                      Navigator.of(context).pop();    // 先返回一下，目的是把侧边栏关上
                                      Navigator.of(context).push(   // 然后跳转到注册页
                                          MaterialPageRoute(builder: (context) {
                                        return Register();
                                      }));
                                    });
                                  },
                                ),
                              ),
                              Container(
                                width: 110,
                                child: RaisedButton(    // 登录按钮
                                  child: Text('登录'),
                                  textColor: Colors.white,
                                  color: Theme.of(context).primaryColor,
                                  disabledColor:
                                      Theme.of(context).primaryColorLight,
                                  disabledTextColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  onPressed: () async { // 点击事件同上面注册
                                    await Future.delayed(
                                        Duration(milliseconds: 200), () {
                                      Navigator.of(context).pop();
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) {
                                        return Login();
                                      }));
                                    });
                                  },
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
            ListTile(
              leading: Icon(Icons.star_border),
              title: Text('我的收藏'),
              onTap: () {   // 点击我的收藏
                if (Provider.of<Store>(context, listen: false)
                        .getUserInfo['id'] ==
                    null) {   // 如果没登陆，跳转到登录页
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    BotToast.showText(
                        text: '请先登录', duration: Duration(seconds: 1));
                    return Login();
                  }));
                } else {    // 登录了的话跳转到收藏页面
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return Favorites();
                  }));
                }
              },
            ),
            ListTile(   // 同我的收藏
              leading: Icon(Icons.notifications_none),
              title: Text('我的关注'),
              onTap: () {
                if (Provider.of<Store>(context, listen: false)
                        .getUserInfo['id'] ==
                    null) {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    BotToast.showText(
                        text: '请先登录', duration: Duration(seconds: 1));
                    return Login();
                  }));
                } else {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return Follow();
                  }));
                }
              },
            ),
            ListTile(   // 点击设置按钮会直接跳转设置页面
              leading: Icon(Icons.settings),
              title: Text('设置'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return Setting();
                }));
              },
            ),
          ],
        ),
      ),
    );
  }
}
