import 'dart:async';
import 'package:flutter/material.dart';
import '../../component/ArticleListItem.dart';
import '../../utils/config.dart';
import '../../component/Loadmore.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List data = [];
  int page = 0;
  bool loadingMore = false;
  bool noMore = false;
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    this._getData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // setState(() {
        //   this.loadingMore = true;
        // });
        this._getData();
      }
    });
  }

  _getData() async {
    var data = await this._fetchData();
    setState(() {
      this.data.addAll(data['list']);
      this.page++;
    });
  }

  Future<Null> _onRefesh() async {
    setState(() {
      this.page = 0;
    });
    var data = await this._fetchData();
    await Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        this.data = data['list'];
      });
    });
  }

  _fetchData() {
    // 获取数据
    return Http()
        .get('/article', params: {'page': this.page.toString(), 'size': '20'});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('首页'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        child: RefreshIndicator(
            onRefresh: this._onRefesh,
            child: ListView.builder(
              itemCount: data.length + 1,
              itemBuilder: (BuildContext context, int index) {
                return index == data.length
                    ? Offstage(
                        offstage: this.loadingMore,
                        child: Loadmore(),
                      )
                    : ArticleListItem(article: data[index]);
              },
            )),
      ),
      drawer: Drawer(),
    );
  }
}
