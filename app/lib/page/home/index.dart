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
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    this._getData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          this.loadingMore = true;
        });
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
    return Column(
      children: <Widget>[
        Expanded(
          child: RefreshIndicator(
              onRefresh: this._onRefesh,
              child: ListView(
                controller: _scrollController,
                children: this.data.map((article) {
                  return ArticleListItem(article: article);
                }).toList(),
              )),
        ),
        // Text('data')
      ],
    );
  }
}
