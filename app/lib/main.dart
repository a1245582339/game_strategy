import 'package:flutter/material.dart';
import './page/home/index.dart';
import './page/follow/index.dart';
import './page/category/index.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  List<Widget> pages= [];

  @override
  void initState() { 
    super.initState();
    pages
      ..add(Home())
      ..add(Category())
      ..add(Follow());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          items: [
            (BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('首页'))),
            BottomNavigationBarItem(
                icon: Icon(Icons.category), title: Text('分类')),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications), title: Text('关注')),
          ],
          currentIndex: _currentIndex,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          }),
    );
  }
}
