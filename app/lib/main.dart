import 'package:app/component/appBar/home.dart';
import 'package:app/component/appBar/notice.dart';
import 'package:app/component/appBar/category.dart';
import 'package:app/page/setting/index.dart';
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
  @override
  void initState() {
    super.initState();
    appBar..add(HomeBar())..add(CategoryBar())..add(NoticeBar());
    pages..add(Home())..add(Category())..add(Notice());

    UserInfo(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar[_currentIndex],
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('首页')),
            BottomNavigationBarItem(
                icon: Icon(Icons.category), title: Text('分类')),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications), title: Text('通知')),
          ],
          currentIndex: _currentIndex,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          }),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Provider.of<Store>(context).getUserInfo['id'] != null
                ? UserAccountsDrawerHeader(
                    accountName: Text(Provider.of<Store>(context)
                            .getUserInfo['nick_name'] ??
                        Provider.of<Store>(context).getUserInfo['login_name']),
                    accountEmail:
                        Text(Provider.of<Store>(context).getUserInfo['email']),
                    currentAccountPicture: CircleAvatar(
                      child: Text('R'),
                    ),
                  )
                : DrawerHeader(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '登录后有新天地',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Text('让你体验私人定制', style: TextStyle(color: Color(0xFF666666))),
                          SizedBox(
                              height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: 110,
                                child: OutlineButton(
                                  child: Text('注册'),
                                  textColor: Theme.of(context).primaryColor,
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor,
                                      width: 1),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  onPressed: () {},
                                ),
                              ),
                              Container(
                                width: 110,
                                child: RaisedButton(
                                  child: Text('登录'),
                                  textColor: Colors.white,
                                  color: Theme.of(context).primaryColor,
                                  disabledColor:
                                      Theme.of(context).primaryColorLight,
                                  disabledTextColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  onPressed: () {
                                      Navigator.of(context).pop();
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                        return Login();
                                    }));
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
              onTap: () {

              },
            ),
            ListTile(
              leading: Icon(Icons.notifications_none),
              title: Text('我的关注'),
              onTap: () {
                  
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('设置'),
              onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
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
