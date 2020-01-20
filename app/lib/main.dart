import 'package:app/component/appBar/home.dart';
import 'package:app/component/appBar/notice.dart';
import 'package:app/component/appBar/category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bot_toast/bot_toast.dart';
import './store/index.dart';
import './page/home/index.dart';
import './page/notice/index.dart';
import './page/category/index.dart';
import './utils/userInfo.dart';

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
                    accountEmail: Text('123123'),
                    currentAccountPicture: CircleAvatar(
                      child: Text('R'),
                    ),
                  )
                : Text('123'),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('设置'),
            )
          ],
        ),
      ),
    );
  }
}
